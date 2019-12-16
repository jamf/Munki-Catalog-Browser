//
//  AppDelegate.swift
//  Munki Catalog Browser
//
//  Copyright © 2019 dataJAR. All rights reserved.
//

import Cocoa
import LetsMove

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        PFMoveToApplicationsFolderIfNecessary()
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        let screenSize = NSScreen.main?.frame
        if let window = NSApplication.shared.mainWindow {
            let windowSize = CGSize(width: (window.frame.width), height: (screenSize?.height)!  )
            window.setFrame(NSRect(origin: (window.frame.origin), size: windowSize), display: true)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
