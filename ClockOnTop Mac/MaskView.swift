//
//  MaskView.swift
//  Clock On Top
//
//  Created by 姜斌 on 2022/9/24.
//

import Cocoa

class MaskView: NSView {
    override init(frame frameRect: NSRect) {
        wantsLayer = true
        layer?.backgroundColor = .clear
    }

    override func updateTrackingAreas() {}
}
