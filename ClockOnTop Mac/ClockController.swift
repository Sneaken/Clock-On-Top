//
//  ClockWindowController.swift
//  Clock On Top
//
//  Created by Robert Wallis on 6/11/2022.
//

import Cocoa
import Foundation

class ClockController: NSViewController {
    let timeLabel = NSTextField(frame: NSRect(x: 0, y: 0, width: 140, height: 35))
    var refreshTimer: Timer?
    var fontSize: CGFloat = 35

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeLabel)
        guard let view = timeLabel.superview else {
            assert(true, "no superview")
            return
        }

        timeLabel.font = NSFont(name: "Raanana", size: 35)
        timeLabel.alignment = .center
        timeLabel.backgroundColor = NSColor.clear
        timeLabel.drawsBackground = false
        timeLabel.isBezeled = false
        timeLabel.autoresizesSubviews = true
        timeLabel.usesSingleLineMode = false
        timeLabel.isEditable = false
        timeLabel.isSelectable = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        NotificationCenter.default.addObserver(self, selector: #selector(onResized), name: NSWindow.didResizeNotification, object: nil)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        refreshTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            let time = dateFormatter.string(from: Date())
            self.timeLabel.stringValue = time
        })
    }

    override func rightMouseUp(with event: NSEvent) {
        let menu = MainMenu()
        NSMenu.popUpContextMenu(menu, with: event, for: view)
    }

    @objc
    func onResized() {
        let heightSize = max(view.frame.height * 0.75, 8)
        let widthSize = max(view.frame.width * 0.2, 8)
        let newFontSize = min(heightSize, widthSize)

        if abs(newFontSize - fontSize) < 1 {
            return
        }
        fontSize = newFontSize

        let newFont = NSFont(name: "Raanana", size: newFontSize)
        timeLabel.font = newFont
    }
}
