//
//  ClockPanel.swift
//  Clock On Top
//
//  Copyright (C) 2021 Robert A. Wallis, All Rights Reserved.
//

import Cocoa

class ClockPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        contentViewController = ClockController()
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        if #available(macOS 11.0, *) {
            toolbarStyle = .unifiedCompact
        }
        isRestorable = true
        level = .floating
        collectionBehavior = [.canJoinAllSpaces, .stationary]
        minSize = NSSize(width: 84, height: 12)
    }
}
