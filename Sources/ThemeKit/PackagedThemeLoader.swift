//
//  PackagedThemeLoader.swift
//  ThemingKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import Foundation


public class PackagedThemeLoader : ThemeLoader {

    public init(bundle : Bundle) {
        super.init()
        self.baseURL = bundle.bundleURL
    }

}
