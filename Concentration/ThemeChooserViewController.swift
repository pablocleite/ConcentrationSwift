//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Pablo Leite on 10/07/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {


    // MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let concentrationViewController = segue.destination as? ConcentrationViewController {
                    if let theme = ThemeFactory.theme(named: themeName) {
                        concentrationViewController.theme = theme
                    } else {
                        print("UhOh! Cannot find theme named \(themeName)")
                    }
                }
            }
        }
    }
}
