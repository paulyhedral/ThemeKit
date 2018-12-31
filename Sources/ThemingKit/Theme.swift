//
//  Theme.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public struct Theme {
    public let id : String
    public var name : String
    public var style : ThemeStyle
    public var primaryFontName : String
    public var secondaryFontName : String
    public var mainColor : UIColor
    public var accent1Color : UIColor
    public var accent2Color : UIColor
    public var background1Color : UIColor
    public var background2Color : UIColor

    public init(id : String, name : String, style : ThemeStyle) {
        self.id = id
        self.name = name
        self.style = style
        self.primaryFontName = UIFont.systemFont(ofSize: UIFont.systemFontSize).familyName
        self.secondaryFontName = UIFont.systemFont(ofSize: UIFont.systemFontSize).familyName
        self.mainColor = .black
        self.accent1Color = .white
        self.accent2Color = .blue
        self.background1Color = .orange
        self.background2Color = .green
    }
}


extension Theme : Equatable, Hashable {
    public static func ==(lhs : Theme, rhs : Theme) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public var hashValue: Int {
        var v : Int = 0

        v ^= id.hashValue
        v ^= name.hashValue
        v ^= style.hashValue
        v ^= primaryFontName.hashValue
        v ^= secondaryFontName.hashValue
        v ^= mainColor.hashValue
        v ^= accent1Color.hashValue
        v ^= accent2Color.hashValue
        v ^= background1Color.hashValue
        v ^= background2Color.hashValue

        return v
    }
}


extension Theme : CustomStringConvertible {

    public var description: String {
        return "Theme { id=\(id); name=\(name); style=\(style); " +
            "primaryFontName=\(primaryFontName); " +
            "secondaryFontName=\(secondaryFontName); " +
            "mainColor=\(mainColor); accent1Color=\(accent1Color); accent2Color=\(accent2Color); " +
            "background1Color=\(background1Color), background2Color=\(background2Color) " +
        "}"
    }

}


extension Theme {

    public mutating func copy(from theme : Theme) {
        self.style = theme.style 
        self.primaryFontName = theme.primaryFontName
        self.secondaryFontName = theme.secondaryFontName
        self.mainColor = theme.mainColor
        self.accent1Color = theme.accent1Color
        self.accent2Color = theme.accent2Color
        self.background1Color = theme.background1Color
        self.background2Color = theme.background2Color
    }

}
