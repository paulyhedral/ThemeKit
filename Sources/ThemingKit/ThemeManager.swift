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
            send(notification: ThemeManager.Notification.ThemeChanged, for: currentTheme.id)
        }
    }

    private var packagedThemes : [String : Theme] = [:]
    private var userThemes : [String : Theme] = [:]

    public init() {
        self.currentTheme = Theme(id: ThemeIdentifier.default.rawValue,
                                  name: "Default")
    }

    public func allThemes() -> [Theme] {
        return (Array<Theme>(packagedThemes.values) + Array<Theme>(userThemes.values)).filter { self.delegate?.isThemeAvailable($0, in: self) ?? true }
    }

    public func theme(id : String) -> Theme? {
        log.debug("\(#function): id=\(id)")

        let t = userThemes[id] ?? packagedThemes[id]
//        for theme in (Array<Theme>(packagedThemes.values) + Array<Theme>(userThemes.values)) {
        log.debug("theme=\(String(describing: t))")

        guard let theme = t else { return nil }
        guard (self.delegate?.isThemeAvailable(theme, in: self) ?? true) else { return nil }

        return theme
//            if theme.id == id {
//                log.debug("Returning theme: \(theme)")
//                return theme
//            }
//        }
//
//        return nil
    }

    public func save(theme : Theme) throws {
        log.debug("Saving theme: \(theme).")

        userThemes[theme.id] = theme

        let fm = FileManager.default

        if let docsUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            let themeUrl = docsUrl.appendingPathComponent("custom-\(theme.id).theme")
            log.debug("themeUrl=\(themeUrl)")
            let writer = ThemeWriter(url: themeUrl)
            try writer.write(theme: theme)

            send(notification: ThemeManager.Notification.ThemeUpdated, for: theme.id)
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
                    self.packagedThemes[theme.id] = theme
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

                    do {
                        let theme = try loader.load(url: url)
                        log.debug("theme=\(theme)")
                        self.userThemes[theme.id] = theme
                    }
                    catch {
                        log.error("Error while trying to load user-defined theme at url \(url): \(error)")
                    }
                }
            }
            catch {
                log.error("Error while trying to load user-defined themes: \(error)")
            }
        }

        log.info("Loaded \(self.userThemes.count) theme(s).")
    }

    private func send(notification name : NSNotification.Name, for id : String) {
        log.debug("\(#function): id=\(id)")

        NotificationCenter.default.post(name: name,
                                        object: self,
                                        userInfo: [
                                            ThemeManager.Notification.Keys.themeIdentifier : id,
                                            ])

    }

}

extension ThemeManager {

    public enum Notification {
        // sent when the current theme changes in the manager
        public static var ThemeChanged = NSNotification.Name("ThemeChanged")
        // sent when a theme's components change value
        public static var ThemeUpdated = NSNotification.Name("ThemeUpdated")

        public enum Keys : String {
            case themeIdentifier = "id"
        }
    }

}
