//
//  main.swift
//  Clock On Top
//
//  Created by Robert Wallis on 6/11/2022.
//

import Foundation
import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
