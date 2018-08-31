//
//  ThemeManager.swift
//  PilgrimageKit
//
//  Created by Paul Schifferer on 28/5/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit
import SwiftyBeaver


public protocol ThemeManagerDelegate : class {
    func process(theme : Theme, in themeManager : ThemeManager) -> Theme
    
    func isThemeAvailable(_ theme : Theme, in themeManager : ThemeManager) -> Bool
}

public class ThemeManager {
    public static let shared = ThemeManager()
    
    public weak var delegate : ThemeManagerDelegate?

    public var currentTheme : Theme

    private var defaultTheme : Theme
    private var packagedThemes : [Theme] = []
    private var userThemes : [Theme] = []
    
    public init() {
        self.defaultTheme = Theme(id: "default",
                                  name: "Default")
        //                                  iconImage: nil, backgroundImage: nil,
        self.defaultTheme.defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.defaultTheme.labelFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        self.defaultTheme.titleBarFont = UIFont.preferredFont(forTextStyle: .title1)
        self.defaultTheme.buttonFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        self.defaultTheme.titleFont = UIFont.preferredFont(forTextStyle: .title2)
        self.defaultTheme.tintColor = .black
        self.defaultTheme.alternateTintColor = .white
        self.defaultTheme.titleBarColor = .orange
        self.defaultTheme.titleBarButtonColor = .green
        self.defaultTheme.titleBarBackgroundColor = .purple
        self.defaultTheme.barStyle = .black

        self.currentTheme = self.defaultTheme
    }
    
    public func allThemes() -> [Theme] {
        return ([defaultTheme] + packagedThemes + userThemes).filter { self.delegate?.isThemeAvailable($0, in: self) ?? true }
    }
    
    public func setDefault(theme : Theme) {
        self.defaultTheme = theme
        self.currentTheme = theme 
    }
    
    public func theme(id : String) -> Theme? {
        log.debug("\(#function): id=\(id)")

        for theme in ([defaultTheme] + packagedThemes + userThemes) {
            if theme.id == id {
                return theme
            }
        }
        
        return nil
    }

    public func save(theme : Theme) throws {

        let fm = FileManager.default

        if let docsUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            let themeUrl = docsUrl.appendingPathComponent("\(ThemeIdentifier.custom.rawValue).theme")
            let writer = try ThemeWriter(url: themeUrl)
            try writer.write(theme: theme)
        }
    }
    
    public func loadPackagedThemes(from bundle : Bundle, resetting : Bool = false) {
        log.info("Loading packaged themes from bundle \(bundle)...")

        if resetting {
            log.debug("Resetting packaged theme list.")
            self.packagedThemes.removeAll()
        }
        
        let loader = PackagedThemeLoader(bundle: bundle)
        if let urls = bundle.urls(forResourcesWithExtension: "theme", subdirectory: nil) {
            log.debug("urls=\(urls)")
            for url in urls {
                log.debug("url=\(url)")
                do {
                    let theme = try loader.load(url: url)
                    log.debug("theme=\(theme)")
                    self.packagedThemes.append(theme)
                }
                catch {
                    log.error("Error while trying to load packaged theme at URL '\(url)': \(error)")
                }
            }
        }
    }
    
    public func loadUserThemes() {
        log.info("Loading user themes...")
        
        let fm = FileManager.default
        
        if let docsUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            let loader = UserDefinedThemeLoader()
            
            do {
                let urls = try fm.contentsOfDirectory(at: docsUrl, includingPropertiesForKeys: nil, options: [ .skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants ])
                for url in urls {
                    guard url.pathExtension == "theme" else { continue }
                    
                    let theme = try loader.load(url: url)
                    self.userThemes.append(theme)
                }
            }
            catch {
                log.error("Error while trying to load user-defined themes: \(error)")
            }
        }
    }
    
}

extension ThemeManager {
    
    public enum Notification {
        public static var ThemeChanged = NSNotification.Name("ThemeChanged")
    }
    
}
