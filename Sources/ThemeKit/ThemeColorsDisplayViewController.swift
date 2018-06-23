//
//  ThemeColorsDisplayViewController.swift
//  InitiativeTracker-iOS
//
//  Created by Paul Schifferer on 16/6/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit
import PilgrimageKit


class ThemeColorsDisplayViewController : UIViewController {

    var theme : Theme = ThemeManager.shared.currentTheme

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if let segueId = segue.identifier {
            var color : UIColor?
            var label : String?

            switch segueId {
            case "EmbedThemeTintColor":
                color = theme.tintColor
                label = NSLocalizedString("", comment: "")

            case "EmbedThemeAltTintColor":
                break

            case "EmbedThemeTitleColor":
                break

            case "EmbedThemeTitleBarColor":
                break

            case "EmbedThemeTitleBarBackgroundColor":
                break

            default: break
            }

            if let c = color,
            let l = label,
                let vc = segue.destination as? CustomColorViewController {
                vc.color = c
                vc.colorTitle = l
            }
        }
    }


}
