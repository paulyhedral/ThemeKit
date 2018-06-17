//
//  UserDefinedThemeLoader.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation


public class UserDefinedThemeLoader : ThemeLoader {
    
    override public init() {
        super.init()
        self.baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
}
