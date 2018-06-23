//
//  ThemeSelectorViewController.swift
//  InitiativeTracker-iOS
//
//  Created by Paul Schifferer on 5/31/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit
import PilgrimageKit


class ThemeSelectorViewController : UIViewController {

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
            var theme : Theme?
            
            switch segueId {
            case "EmbedDarkThemeDetails":
                 theme = ThemeManager.shared.theme(id: ThemeIdentifier.dark.rawValue)

            case "EmbedLightThemeDetails":
                theme = ThemeManager.shared.theme(id: ThemeIdentifier.light.rawValue)

            case "EmbedCustomThemeDetails":
                theme = ThemeManager.shared.theme(id: ThemeIdentifier.custom.rawValue)

            default: break
            }
            
            if let t = theme,
                let vc = segue.destination as? ThemeColorsDisplayViewController {
vc.theme = t
            }
        }
    }
    

}
