//
//  ThemeColorsDisplayViewController.swift
//  ThemeKit
//
//  Created by Paul Schifferer on 8/28/18.
//

import UIKit


public class ThemeColorsDisplayViewController: UIViewController {

    public var theme : Theme = Theme(id: "none", name: "None")

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let segueId = segue.identifier,
            let vc = segue.destination as? CustomColorViewController {
            switch segueId {
            case "EmbedThemeTitleBarBackgroundColor":
                vc.label = NSLocalizedString("xyz", comment: "")
                vc.color = theme.titleBarBackgroundColor

            case "EmbedThemeTintColor":
                vc.label = NSLocalizedString("xyz", comment: "")
                vc.color = theme.tintColor

            case "EmbedThemeTitleColor":
                vc.label = NSLocalizedString("xyz", comment: "")
                vc.color = theme.titleBarButtonColor

            case "EmbedThemeAltTintColor":
                vc.label = NSLocalizedString("xyz", comment: "")
                vc.color = theme.alternateTintColor

            case "EmbedThemeTitleBarColor":
                vc.label = NSLocalizedString("xyz", comment: "")
                vc.color = theme.titleBarColor

            default: break
            }
        }
    }


}
