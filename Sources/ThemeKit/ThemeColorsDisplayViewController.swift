//
//  ThemeColorsDisplayViewController.swift
//  ThemeKit
//
//  Created by Paul Schifferer on 8/28/18.
//

import UIKit


public protocol ThemeColorSelectionDelegate : class {

    func didSelect(component : ThemeComponent, in viewController : ThemeColorsDisplayViewController)

}

public class ThemeColorsDisplayViewController : UIViewController, CustomColorHandler {

    public var theme : Theme = Theme(id: "none", name: "None")
    public weak var selectionDelegate : ThemeColorSelectionDelegate?

    private var tintColorButton : UIButton?
    private var alternateTintColorButton : UIButton?
    private var titleBarColorButton : UIButton?
    private var titleBarButtonColorButton : UIButton?
    private var titleBarBackgroundColorButton : UIButton?

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    public override func prepare(for segue : UIStoryboardSegue, sender : Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let segueId = segue.identifier,
            let vc = segue.destination as? CustomColorViewController {
            switch segueId {
            case "EmbedThemeTitleBarBackgroundColor":
                vc.component = ThemeComponent.titleBarBackgroundColor
                vc.label = NSLocalizedString("color.titlebarbackground.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.titleBarBackgroundColor
                vc.handler = self

            case "EmbedThemeTintColor":
                vc.component = ThemeComponent.tintColor
                vc.label = NSLocalizedString("color.tint.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.tintColor
                vc.handler = self

            case "EmbedThemeTitleColor":
                vc.component = ThemeComponent.titleBarButtonColor
                vc.label = NSLocalizedString("color.title.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.titleBarButtonColor
                vc.handler = self

            case "EmbedThemeAltTintColor":
                vc.component = ThemeComponent.alternateTintColor
                vc.label = NSLocalizedString("color.alternatetint.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.alternateTintColor
                vc.handler = self

            case "EmbedThemeTitleBarColor":
                vc.component = ThemeComponent.titleBarColor
                vc.label = NSLocalizedString("color.titlebar.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.titleBarColor
                vc.handler = self

            default: break
            }
        }
    }


    // MARK: - Custom color handler methods

    public func colorTouched(for component : ThemeComponent, in viewController : CustomColorViewController) {
        self.selectionDelegate?.didSelect(component: component, in: self)
    }

}
