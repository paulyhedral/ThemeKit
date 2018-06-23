//
//  AppearanceFunctions.swift
//  CharacterManager
//
//  Created by Paul Schifferer on 10/11/15.
//  Copyright © 2015 Pilgrimage Software. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif


public class AppearanceManager {
    public static let shared = AppearanceManager()

    #if os(iOS)
    public var barStyle : UIBarStyle = .black
    #endif

    public var defaultFontName : String = "AvenirNext-Regular"
    public var labelFontName : String = "Monaco"
    public var titleBarFontName : String = "AvenirNext-Bold"
    public var buttonFontName : String = "AvenirNextCondensed-Regular"
    public var titleFontName : String = "AvenirNext-DemiBold"

    public var tintColor : UIColor = .black
    public var alternateTintColor : UIColor = .orange
    public var titleBarBackgroundColor : UIColor = .red
    public var titleBarColor : UIColor = .blue
    public var titleBarButtonColor : UIColor = .green

    public init() {

    }

    public func setupDefaultAppearance() {

        //    UILabel.appearance().font = labelFont()
        #if os(iOS)
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName : titleBarFont(),
            NSForegroundColorAttributeName : titleBarColor, // UIColor(white: 230.0 / 255.0, alpha: 1),
            //UIColor(red: 36.0 / 255.0, green: 107.0 / 255.0, blue: 208.0 / 255.0, alpha: 1)
        ]
        UINavigationBar.appearance().barTintColor = titleBarBackgroundColor
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSFontAttributeName : buttonFont(),
            NSForegroundColorAttributeName : titleBarButtonColor,
            ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSFontAttributeName : buttonFont(),
            NSForegroundColorAttributeName : UIColor.darkGray,
            ], for: .disabled)
        #else
        // TODO
        #endif
    }

    public func setup(using theme : Theme) {
        #if os(iOS)
        self.barStyle = theme.barStyle
        #endif

        self.defaultFontName = theme.defaultFont.fontName
        self.labelFontName = theme.labelFont.fontName
        self.titleBarFontName = theme.titleBarFont.fontName
        self.buttonFontName = theme.buttonFont.fontName
        self.titleFontName = theme.titleFont.fontName

        self.tintColor = theme.tintColor
        self.alternateTintColor = theme.alternateTintColor
        self.titleBarBackgroundColor = theme.titleBarBackgroundColor
        self.titleBarColor = theme.titleBarColor
        self.titleBarButtonColor = theme.titleBarButtonColor

        self.setupDefaultAppearance()
    }


    // MARK - Fonts

    public func defaultFont(size : Float = 17, scale : Float = 1.0) -> Font {
        return Font(name: defaultFontName, size: CGFloat(size * scale)) ?? Font.systemFont(ofSize: CGFloat(size * scale))
    }

    public func labelFont(size : Float = 20, scale : Float = 1.0) -> Font {
        return Font(name: labelFontName, size: CGFloat(size * scale)) ?? Font.systemFont(ofSize: CGFloat(size * scale))
    }

    public func titleBarFont(size : Float = 28, scale : Float = 1.0) -> Font {
        return Font(name: titleBarFontName, size: CGFloat(size * scale)) ?? Font.systemFont(ofSize: CGFloat(size * scale))
    }

    public func buttonFont(size : Float = 15, scale : Float = 1.0) -> Font {
        return Font(name: buttonFontName, size: CGFloat(size * scale)) ?? Font.systemFont(ofSize: CGFloat(size * scale))
    }

    public func titleFont(size : Float = 17, scale : Float = 1.0) -> Font {
        return Font(name: titleFontName, size: CGFloat(size * scale)) ?? Font.systemFont(ofSize: CGFloat(size * scale))
    }

}
