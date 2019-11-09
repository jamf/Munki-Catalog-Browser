//
//  ViewController.swift
//  Munki Catalog Browser
//
//  Copyright © 2019 dataJAR. All rights reserved.
//

import Foundation

struct InstallItems: Codable {
    var CFBundleIdentifier: String?
    var CFBundleName: String?
    var CFBundleShortVersionString: String?
    var CFBundleVersion: String?
    var minosversion: String?
    var path: String?
    var type: String?
    var version_comparison_key: String?
}

struct Receipts: Codable{
    var installed_size: Int?
    var packageid: String?
    var version: String?
}

struct MunkiApp: Codable {
    var autoremove: Bool?
    var catalog: String?
    var category: String?
    var description: String?
    var developer: String?
    var display_name: String?
    var installed_size: Int?
    var installer_item_hash: String?
    var installer_item_location: String?
    var installer_item_size: Int?
    var installs: [InstallItems]?
    var minimum_os_version: String?
    var name: String?
    var package_path: String?
    var preuninstall_script: String?
    var receipts: [Receipts]?
    var unattended_install: Bool?
    var unattended_uninstall: Bool?
    var uninstall_method: String?
    var uninstallable: Bool?
    var version: String?
}
