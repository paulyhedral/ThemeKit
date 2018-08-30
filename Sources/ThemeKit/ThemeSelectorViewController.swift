//
//  Theme.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public class ThemeSelectorViewController : UIViewController {

    @IBOutlet var darkThemeTapGesture: UITapGestureRecognizer!
    @IBOutlet var lightThemeTapGesture: UITapGestureRecognizer!
    @IBOutlet var customThemeTapGesture: UITapGestureRecognizer!

    public override func viewDidLoad() {
        super.viewDidLoad()

    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier,
            let vc = segue.destination as? ThemeColorsDisplayViewController {
            switch segueId {
            case "EmbedLightThemeDetails":
                if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.light.rawValue) {
                    vc.theme = theme
                }

            case "EmbedDarkThemeDetails":
                if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.dark.rawValue) {
                    vc.theme = theme
                }

            case "EmbedCustomThemeDetails":
                if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.custom.rawValue) {
                    vc.theme = theme
                }

            default: break
            }
        }
    }

    @IBAction func darkThemeSelected(_ sender: UITapGestureRecognizer) {
    }

    @IBAction func lightThemeSelected(_ sender: UITapGestureRecognizer) {
    }

    @IBAction func customThemeSelected(_ sender: UITapGestureRecognizer) {
    }

}
