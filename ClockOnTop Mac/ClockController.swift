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

    var kb_V: NSView?

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

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = .clear

        // 上下左右留10px 使之能够调整大小
        kb_V = NSView(frame: NSMakeRect(10, 10, 160, 30))
        self.view.addSubview(kb_V!)
        kb_V!.wantsLayer = true
        kb_V!.layer?.backgroundColor = .clear
        // 添加——追踪‘鼠标’的区域
        // 【一】通过枚举项的原始值`rawValue`来通过“|”或运算，得到新的NSTrackingArea.Options来使用
        let opt = (
            NSTrackingArea.Options.mouseEnteredAndExited.rawValue |
                NSTrackingArea.Options.mouseMoved.rawValue |
                NSTrackingArea.Options.activeAlways.rawValue |
                NSTrackingArea.Options.inVisibleRect.rawValue
        )
        let trackingArea = NSTrackingArea(rect: kb_V!.frame, options: NSTrackingArea.Options(rawValue: opt), owner: self, userInfo: nil)
        self.view.addTrackingArea(trackingArea)
    }

    override func rightMouseUp(with event: NSEvent) {
        let menu = MainMenu()
        NSMenu.popUpContextMenu(menu, with: event, for: view)
    }

    override func mouseMoved(with event: NSEvent) {
        if event.locationInWindow.x > 10 && event.locationInWindow.x < view.frame.width - 10 && event.locationInWindow.y > 10 && event.locationInWindow.y < view.frame.height - 10  {
            // 鼠标移入的时候窗体透明
            view.window?.alphaValue = 0.2
            // 鼠标移入的时候使鼠标穿透
            view.window?.ignoresMouseEvents = true
        } else {
            view.window?.alphaValue = 1
            view.window?.ignoresMouseEvents = false
        }
    }

    override func mouseExited(with event: NSEvent) {
        // 鼠标移出的时候 与之相反
        view.window?.alphaValue = 1
        view.window?.ignoresMouseEvents = false
    }

    @objc
    func onResized() {
//        kb_V?.frame.size = NSSize(width: view.frame.width - 20, height: view.frame.height - 20)
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
