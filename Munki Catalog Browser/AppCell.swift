//
//  AppCell.swift
//  JamJar Apps
//
//  Created by Richard Mallion on 06/07/2018.
//  Copyright © 2018 dataJAR. All rights reserved.
//

import Cocoa

class AppCell: NSTableCellView {
    @IBOutlet weak var appIcon: NSImageView!
    @IBOutlet weak var appName: NSTextField!
    @IBOutlet weak var munkiName: NSTextField!
    @IBOutlet weak var appVersion: NSTextField!
    @IBOutlet weak var munkiCatalog: NSTextField!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
}
