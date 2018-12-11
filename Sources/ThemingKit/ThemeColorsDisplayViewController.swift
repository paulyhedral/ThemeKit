//
//  ThemeColorsDisplayViewController.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 8/28/18.
//

import UIKit


public protocol ThemeColorSelectionDelegate : class {

    func didSelect(component : ThemeColorType, in viewController : ThemeColorsDisplayViewController)

}

public class ThemeColorsDisplayViewController : UIViewController, CustomColorHandler {

    @IBOutlet weak var mainColorContainer : UIView!
    @IBOutlet weak var accentColorContainer : UIView!
    @IBOutlet weak var secondAccentColorContainer : UIView!
    @IBOutlet weak var backgroundColorContainer : UIView!

    public var theme : Theme = Theme(id: "none", name: "None") {
        didSet {
            componentControllers[.mainColor]?.color = theme.mainColor
            componentControllers[.accentColor]?.color = theme.accentColor
            componentControllers[.secondAccentColor]?.color = theme.secondAccentColor
            componentControllers[.backgroundColor]?.color = theme.backgroundColor
        }
    }
    public weak var selectionDelegate : ThemeColorSelectionDelegate?

    private var componentControllers : [ThemeColorType : CustomColorViewController] = [:]

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //        select(component: .mainColor)
        //        self.selectionDelegate?.didSelect(component: .mainColor, in: self)
    }


    // MARK: - API

    public func select(component : ThemeColorType) {
        doComponentSelection(mainColorContainer, selected: (component == .mainColor))
        doComponentSelection(accentColorContainer, selected: (component == .accentColor))
        doComponentSelection(secondAccentColorContainer, selected: (component == .secondAccentColor))
        doComponentSelection(backgroundColorContainer, selected: (component == .backgroundColor))
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
            case "EmbedThemeBackgroundColor":
                vc.component = .backgroundColor
                vc.label = NSLocalizedString("color.background.label", tableName: "ThemingKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.backgroundColor
                vc.handler = self
                self.componentControllers[.backgroundColor] = vc

            case "EmbedThemeMainColor":
                vc.component = .mainColor
                vc.label = NSLocalizedString("color.main.label", tableName: "ThemingKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.mainColor
                vc.handler = self
                self.componentControllers[.mainColor] = vc

            case "EmbedThemeAccentTintColor":
                vc.component = .accentColor
                vc.label = NSLocalizedString("color.accent.label", tableName: "ThemingKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.accentColor
                vc.handler = self
                self.componentControllers[.accentColor] = vc

            case "EmbedThemeSecondAccentColor":
                vc.component = .secondAccentColor
                vc.label = NSLocalizedString("color.secondaccent.label", tableName: "ThemingKit", bundle: Bundle(for: ThemeColorsDisplayViewController.self), comment: "")
                vc.color = theme.secondAccentColor
                vc.handler = self
                self.componentControllers[.secondAccentColor] = vc

            default: break
            }
        }
    }


    // MARK: - Custom color handler methods

    public func colorTouched(for component : ThemeColorType, in viewController : CustomColorViewController) {
        select(component: component)
        self.selectionDelegate?.didSelect(component: component, in: self)
    }

}
