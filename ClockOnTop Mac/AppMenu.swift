//
//  AppMenu.swift
//  Clock On Top
//
//  Created by Robert Wallis on 6/12/2022.
//

import Cocoa

class AppMenu: NSMenu {
    private lazy var appName = ProcessInfo.processInfo.processName

    override init(title: String) {
        super.init(title: title)
        let main = NSMenuItem()
        main.submenu = NSMenu(title: "MainMenu")
        main.submenu?.items = [
            NSMenuItem(title: "About \(appName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"),
        ]
        items = [main]
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
