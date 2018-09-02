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

    public var currentTheme : Theme {
        didSet {
            sendNotification(for: currentTheme.id)
        }
    }

    private var packagedThemes : [Theme] = []
    private var userThemes : [Theme] = []
    
    public init() {
        self.currentTheme = Theme(id: ThemeIdentifier.default.rawValue,
                                  name: "Default")
    }
    
    public func allThemes() -> [Theme] {
        return (packagedThemes + userThemes).filter { self.delegate?.isThemeAvailable($0, in: self) ?? true }
    }
    
    public func theme(id : String) -> Theme? {
        log.debug("\(#function): id=\(id)")

        for theme in (packagedThemes + userThemes) {
            log.debug("theme=\(theme)")
            if theme.id == id {
                log.debug("Returning theme: \(theme)")
                return theme
            }
        }
        
        return nil
    }

    public func save(theme : Theme) throws {
        log.debug("Saving theme: \(theme).")

        let fm = FileManager.default

        if let docsUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            let themeUrl = docsUrl.appendingPathComponent("custom-\(theme.id).theme")
            log.debug("themeUrl=\(themeUrl)")
            let writer = try ThemeWriter(url: themeUrl)
            try writer.write(theme: theme)
        }
    }
    
    public func loadPackagedThemes(from bundle : Bundle, resetting : Bool = false) {
        log.info("Loading packaged themes from bundle: \(bundle)...")

        if resetting {
            log.debug("Resetting packaged theme list.")
            self.packagedThemes.removeAll()
        }
        
        let loader = PackagedThemeLoader(bundle: bundle)
        if let urls = bundle.urls(forResourcesWithExtension: "theme", subdirectory: nil) {
            log.debug("urls=\(urls)")
            for url in urls {
                log.debug("url=\(url.absoluteString)")
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
                log.debug("urls=\(urls)")
                for url in urls {
                    log.debug("url=\(url)")
                    guard url.pathExtension == "theme" else { continue }
                    
                    let theme = try loader.load(url: url)
                    log.debug("theme=\(theme)")
                    self.userThemes.append(theme)
                }
            }
            catch {
                log.error("Error while trying to load user-defined themes: \(error)")
            }
        }

        log.info("Loaded \(self.userThemes.count) theme(s).")
    }

    private func sendNotification(for id : String) {
        log.debug("\(#function): id=\(id)")

        NotificationCenter.default.post(name: ThemeManager.Notification.ThemeChanged,
                                        object: self,
                                        userInfo: [
                                            ThemeManager.Notification.Keys.themeIdentifier : id,
            ])

    }
    
}

extension ThemeManager {
    
    public enum Notification {
        public static var ThemeChanged = NSNotification.Name("ThemeChanged")

        public enum Keys : String {
            case themeIdentifier = "id"
        }
    }
    
}
