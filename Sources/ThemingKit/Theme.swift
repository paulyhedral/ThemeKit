//
//  Theme.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit


public struct Theme {
    public let id : String
    public let name : String
    public var defaultFont : UIFont
    public var labelFont : UIFont
    public var titleBarFont : UIFont
    public var buttonFont : UIFont
    public var titleFont : UIFont
    public var tintColor : UIColor
    public var alternateTintColor : UIColor
    public var titleBarTextColor : UIColor
    public var titleBarButtonLabelColor : UIColor
    public var titleBarBackgroundColor : UIColor
    public var barStyle : UIBarStyle = .black

    public init(id : String, name : String) {
        self.id = id
        self.name = name
        self.defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.labelFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.titleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.titleBarFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.buttonFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.tintColor = .black
        self.alternateTintColor = .white
        self.titleBarTextColor = .blue
        self.titleBarButtonLabelColor = .orange
        self.titleBarBackgroundColor = .green 
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
        v ^= defaultFont.hashValue
        v ^= labelFont.hashValue
        v ^= titleBarFont.hashValue
        v ^= buttonFont.hashValue
        v ^= titleFont.hashValue
        v ^= tintColor.hashValue
        v ^= alternateTintColor.hashValue
        v ^= titleBarTextColor.hashValue
        v ^= titleBarButtonLabelColor.hashValue
        v ^= titleBarBackgroundColor.hashValue

        return v
    }
}


extension Theme : CustomStringConvertible {

    public var description: String {
        return "Theme { id=\(id); name=\(name); defaultFont=\(defaultFont); labelFont=\(labelFont); " +
        "titleBarFont=\(titleBarFont); buttonFont=\(buttonFont); titleFont=\(titleFont); " +
        "tintColor=\(tintColor); alternateTintColor=\(alternateTintColor); titleBarTextColor=\(titleBarTextColor); " +
        "titleBarButtonLabelColor=\(titleBarButtonLabelColor); titleBarBackgroundColor\(titleBarBackgroundColor) }"
    }

}


extension Theme {

    public mutating func copy(from theme : Theme) {
        self.alternateTintColor = theme.alternateTintColor
        self.barStyle = theme.barStyle
        self.buttonFont = theme.buttonFont
        self.defaultFont = theme.defaultFont
        self.labelFont = theme.labelFont
        self.tintColor = theme.tintColor
        self.titleBarBackgroundColor = theme.titleBarBackgroundColor
        self.titleBarButtonLabelColor = theme.titleBarButtonLabelColor
        self.titleBarTextColor = theme.titleBarTextColor
        self.titleBarFont = theme.titleBarFont
        self.titleFont = theme.titleFont
    }

}
