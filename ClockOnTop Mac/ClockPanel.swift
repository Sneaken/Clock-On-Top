//
//  ClockPanel.swift
//  Clock On Top
//
//  Copyright (C) 2021 Robert A. Wallis, All Rights Reserved.
//

import Cocoa

class ClockWindow: NSPanel {

	@IBOutlet weak var timeLabel: NSTextField!
	var refreshTimer: Timer?
	var fontSize: CGFloat = 36.0

	override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
		super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)

		NotificationCenter.default.addObserver(self, selector: #selector(onResized), name: NSWindow.didResizeNotification, object: nil)

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "hh:mm:ss"

		refreshTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in

			let time = dateFormatter.string(from: Date())
			self.timeLabel?.stringValue = time

		})
	}

	@objc
	func onResized()
	{
		guard let timeLabel = self.timeLabel else { return }

		let heightSize = max(self.frame.height * 0.75, 8)
		let widthSize = max(self.frame.width * 0.23, 8)
		let newFontSize = min(heightSize, widthSize)

		print("on resized \(self.frame.width)x\(self.frame.height) to font \(heightSize) \(widthSize)")

		if abs(newFontSize - fontSize) < 2 {
			return
		}
		fontSize = newFontSize

		let newFont = NSFont.systemFont(ofSize: newFontSize)
		timeLabel.font = newFont
	}
}
