//
//  ThemeConstants.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation
import SwiftyBeaver


let log = SwiftyBeaver.self

public enum ThemeIdentifier : String {
    case dark = "dark"
    case light = "light"
    case custom = "custom"
    case `default` = "default"
}

public enum ThemeComponent {
    case mainColor
    case accentColor
    case secondAccentColor
    case backgroundColor
}
