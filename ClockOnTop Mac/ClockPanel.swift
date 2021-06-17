//
//  ClockPanel.swift
//  Clock On Top
//
//  Copyright (C) 2021 Robert A. Wallis, All Rights Reserved.
//

import Cocoa

class ClockPanel: NSPanel {

	@IBOutlet weak var timeLabel: NSTextField!
	var refreshTimer: Timer?

	override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
		super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "hh:mm:ss"

		refreshTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in

			let time = dateFormatter.string(from: Date())
			self.timeLabel?.stringValue = time

		})
	}

	override func setIsVisible(_ flag: Bool) {
		refreshTimer?.fire()
		self.setIsVisible(flag)
	}
}
