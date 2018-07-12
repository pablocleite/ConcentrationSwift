//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Pablo Leite on 10/07/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    private var splitDetailViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    @IBAction func changeTheme(_ sender: UIButton) {
        if let concentrationViewController = splitDetailViewController, let themeName = sender.currentTitle {
            setTheme(named: themeName, on: concentrationViewController)
        } else if let concentrationVIewController = lastSeguedToConcentrationViewController, let themeName = sender.currentTitle {
            setTheme(named: themeName, on: concentrationVIewController )
            navigationController?.pushViewController(concentrationVIewController, animated: true)
        } else {
            performSegue(withIdentifier: "Choose theme", sender: sender)
        }
        //After setting a theme the preferredDisplayMode can become automatic again so iPads can properly adjust the UI accordingly.
        splitViewController?.preferredDisplayMode = .automatic
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .primaryOverlay
    }
    
    // MARK - UISplitViewControllerDelegate
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let concentrationViewController = secondaryViewController as? ConcentrationViewController {
            if concentrationViewController.theme == nil {
                return true
            }
        }
        return false
    }
    
    // MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let concentrationViewController = segue.destination as? ConcentrationViewController {
                    setTheme(named: themeName, on: concentrationViewController)
                    lastSeguedToConcentrationViewController = concentrationViewController
                }
            }
        }
    }
    
    //MARK - Private methods
    private func setTheme(named themeName: String, on concentrationViewController: ConcentrationViewController) {
        if let theme = ThemeFactory.theme(named: themeName) {
            concentrationViewController.theme = theme
        } else {
            print("UhOh! Cannot find theme named \(themeName)")
        }
    }
}
