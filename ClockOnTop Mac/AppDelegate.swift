//
//  AppDelegate.swift
//  Clock On Top
//
//  Copyright (C) 2021 Robert A. Wallis, All Rights Reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: ClockPanel!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = ClockPanel(
            contentRect: NSRect(x: 0, y: 0, width: 150, height: 40),
            styleMask: [
                .borderless,
                .titled,
                .resizable,
                .utilityWindow,
                .hudWindow,
                .fullSizeContentView,
                .nonactivatingPanel
            ],
            backing: .buffered,
            defer: false)
        let controller = NSWindowController(window: window)
        window.center()
        controller.showWindow(self)
        window.makeKeyAndOrderFront(self)
        window.setFrameUsingName("clockWindow", force: false)
        window.orderFrontRegardless()
    }

    func applicationWillTerminate(_ notification: Notification) {
        window.saveFrame(usingName: "clockWindow")
    }
}
