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

    @IBOutlet weak var tintColorContainer : UIView!
    @IBOutlet weak var alternateTintColorContainer : UIView!
    @IBOutlet weak var titleBarColorContainer : UIView!
    @IBOutlet weak var titleBarButtonColorContainer : UIView!
    @IBOutlet weak var titleBarBackgroundColorContainer : UIView!

    public var theme : Theme = Theme(id: "none", name: "None") {
        didSet {
            componentControllers[.tintColor]?.color = theme.tintColor
            componentControllers[.alternateTintColor]?.color = theme.alternateTintColor
            componentControllers[.titleBarColor]?.color = theme.titleBarColor
            componentControllers[.titleBarButtonColor]?.color = theme.titleBarButtonColor
            componentControllers[.titleBarBackgroundColor]?.color = theme.titleBarBackgroundColor
        }
    }
    public weak var selectionDelegate : ThemeColorSelectionDelegate?

    private var componentControllers : [ThemeComponent : CustomColorViewController] = [:]

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //        select(component: .tintColor)
        //        self.selectionDelegate?.didSelect(component: .tintColor, in: self)
    }


    // MARK: - API

    public func select(component : ThemeComponent) {
        doComponentSelection(tintColorContainer, selected: (component == .tintColor))
        doComponentSelection(alternateTintColorContainer, selected: (component == .alternateTintColor))
        doComponentSelection(titleBarColorContainer, selected: (component == .titleBarColor))
        doComponentSelection(titleBarButtonColorContainer, selected: (component == .titleBarButtonColor))
        doComponentSelection(titleBarBackgroundColorContainer, selected: (component == .titleBarBackgroundColor))
    }


    // MARK: - Private methods

    private func doComponentSelection(_ button : UIView, selected : Bool) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = (selected ? 1 : 0)
        button.layer.borderColor = (selected ? UIColor.lightGray.cgColor : UIColor.clear.cgColor)
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
                self.componentControllers[.titleBarBackgroundColor] = vc

            case "EmbedThemeTintColor":
                vc.component = ThemeComponent.tintColor
                vc.label = NSLocalizedString("color.tint.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.tintColor
                vc.handler = self
                self.componentControllers[.tintColor] = vc

            case "EmbedThemeTitleBarButtonColor":
                vc.component = ThemeComponent.titleBarButtonColor
                vc.label = NSLocalizedString("color.titlebarbutton.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.titleBarButtonColor
                vc.handler = self
                self.componentControllers[.titleBarButtonColor] = vc

            case "EmbedThemeAltTintColor":
                vc.component = ThemeComponent.alternateTintColor
                vc.label = NSLocalizedString("color.alternatetint.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.alternateTintColor
                vc.handler = self
                self.componentControllers[.alternateTintColor] = vc

            case "EmbedThemeTitleBarColor":
                vc.component = ThemeComponent.titleBarColor
                vc.label = NSLocalizedString("color.titlebar.label", tableName: "ThemeKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.titleBarColor
                vc.handler = self
                self.componentControllers[.titleBarColor] = vc

            default: break
            }
        }
    }


    // MARK: - Custom color handler methods

    public func colorTouched(for component : ThemeComponent, in viewController : CustomColorViewController) {
        select(component: component)
        self.selectionDelegate?.didSelect(component: component, in: self)
    }

}
