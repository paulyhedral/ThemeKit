//
//  ThemeSelectorViewController.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

// import UIKit


// public class ThemeSelectorViewController : UIViewController {

//     @IBOutlet var darkThemeTapGesture: UITapGestureRecognizer!
//     @IBOutlet weak var darkThemeSelectedImage : UIImageView!
//     @IBOutlet var lightThemeTapGesture: UITapGestureRecognizer!
//     @IBOutlet weak var lightThemeSelectedImage : UIImageView!
//     @IBOutlet var customThemeTapGesture: UITapGestureRecognizer!
//     @IBOutlet weak var customThemeSelectedImage : UIImageView!

//     public override func viewDidLoad() {
//         super.viewDidLoad()

//         updateSelection()
//     }

//     public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         if let segueId = segue.identifier,
//             let vc = segue.destination as? ThemeColorsDisplayViewController {
//             switch segueId {
//             case "EmbedLightThemeDetails":
//                 if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.light.rawValue) {
//                     vc.theme = theme
//                 }

//             case "EmbedDarkThemeDetails":
//                 if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.dark.rawValue) {
//                     vc.theme = theme
//                 }

//             case "EmbedCustomThemeDetails":
//                 if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.custom.rawValue) {
//                     vc.theme = theme
//                 }

//             default: break
//             }
//         }
//     }


//     // MARK: - UI callbacks

//     @IBAction func darkThemeSelected(_ sender : UITapGestureRecognizer) {
//         if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.dark.rawValue) {
//             ThemeManager.shared.currentTheme = theme
//         }

//         updateSelection()
//     }

//     @IBAction func lightThemeSelected(_ sender : UITapGestureRecognizer) {
//         if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.light.rawValue) {
//             ThemeManager.shared.currentTheme = theme
//         }

//         updateSelection()
//     }

//     @IBAction func customThemeSelected(_ sender : UITapGestureRecognizer) {
//         if let theme = ThemeManager.shared.theme(id: ThemeIdentifier.custom.rawValue) {
//             ThemeManager.shared.currentTheme = theme
//         }

//         updateSelection()
//     }


//     // MARK: - Private methods

//     private func updateSelection() {

//         let theme = ThemeManager.shared.currentTheme

//         darkThemeSelectedImage.isHidden = (theme.id != ThemeIdentifier.dark.rawValue)
//         lightThemeSelectedImage.isHidden = (theme.id != ThemeIdentifier.light.rawValue)
//         customThemeSelectedImage.isHidden = (theme.id != ThemeIdentifier.custom.rawValue)
//     }

// }
