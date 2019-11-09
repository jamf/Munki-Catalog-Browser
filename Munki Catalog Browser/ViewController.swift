//
//  ViewController.swift
//  Munki Catalog Browser
//
//  Copyright © 2019 dataJAR. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var filteredAppsFound = [MunkiApp]()
    var appsFound = [MunkiApp]()

    @IBOutlet weak var myTableView: NSTableView!
    @IBOutlet weak var searchField: NSSearchField!
    @IBAction func showHelp(_ sender: Any?) {
        NSWorkspace.shared.open(URL(string: "https://github.com/dataJAR/Munki-Catalog-Browser")!)
    }

    let appDelegate = NSApplication.shared.delegate as! AppDelegate

    @IBAction func refresh(_ sender: Any) {
        filteredAppsFound = [MunkiApp]()
        appsFound = [MunkiApp]()
        myTableView.reloadData()
        readCatalogs()
    }

    func readCatalogs() {
        appsFound = [MunkiApp]()
        let fm = FileManager.default
        do {
            let defaultInstallDir = "/Library/Managed Installs"
            let munkiDefaults = UserDefaults(suiteName: "ManagedInstalls")
            let foundInstallDir = munkiDefaults?.object(forKey: "ManagedInstallDirs")
            let managedInstallDir = foundInstallDir ?? defaultInstallDir
            let munkiCatalogsDir = URL(fileURLWithPath: "\(managedInstallDir)\("/catalogs")")
            let catalogsDir = try fm.contentsOfDirectory(at: munkiCatalogsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for foundCatalog in catalogsDir {
                print("Found \(foundCatalog)")
                lookupApps(munkiCatalogFile: foundCatalog)
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }

    func lookupApps(munkiCatalogFile: URL) {
        if let data = try? Data(contentsOf: munkiCatalogFile) {
            do {
                let decoder = PropertyListDecoder()
                var apps = try decoder.decode([MunkiApp].self, from: data)
                let catalogName = munkiCatalogFile.lastPathComponent
                apps.mutateEach { app in
                    app.catalog = catalogName
                }
                self.appsFound = self.appsFound + apps
                self.appsFound = self.appsFound.sorted {
                    guard let display_name0 = $0.display_name, let display_name1 = $1.display_name else { return false }
                    return display_name0.lowercased() < display_name1.lowercased()
                }
                
                self.filteredAppsFound = self.appsFound
                DispatchQueue.main.async(){
                    self.myTableView.reloadData()
                }
            } catch {
                // Handle error
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSApplication.shared.windows.first?.styleMask = .titled
        myTableView.delegate = self
        myTableView.dataSource = self
        searchField.delegate = self
        readCatalogs()
    }

    override func awakeFromNib() {
        myTableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }

    @objc func tableViewDoubleClick(_ sender:AnyObject){
        rowSelected()
    }

    func rowSelected() {
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 36 {
            rowSelected()
        }
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filteredAppsFound.count
    }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let currentApp = filteredAppsFound[row]
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "myCell"), owner: nil) as? AppCell {
            if let display_name = currentApp.display_name {
                cell.appName.stringValue = display_name
            } else {
                cell.appName?.stringValue = ""
            }
            if let version = currentApp.version {
                cell.appVersion.stringValue = version
            } else {
                cell.appVersion.stringValue = ""
            }
            if let munkiName = currentApp.name {
                cell.munkiName.stringValue = munkiName
            } else {
                cell.munkiName.stringValue = ""
            }
            if let munkiCatalog = currentApp.catalog {
                cell.munkiCatalog.stringValue = munkiCatalog
            } else {
                cell.munkiCatalog.stringValue = ""
            }
            return cell
        }
        return nil
    }

    func saveToLocation(fileName: String, data: String) {
        let panel = NSSavePanel()
        panel.canCreateDirectories = true
        panel.allowedFileTypes = ["csv"]
        panel.canSelectHiddenExtension = true
        panel.isExtensionHidden = false
        panel.nameFieldStringValue = fileName
        panel.beginSheetModal(for: self.view.window!) { (result) -> Void in
            if result.rawValue == NSFileHandlingPanelOKButton
            {
                guard let url = panel.url else { return }
                do {
                    try data.write(to: url, atomically: true, encoding: String.Encoding.utf8)
                    DispatchQueue.main.async(){
                        print("Sucess")
                    }
                } catch {
                    print (error.localizedDescription)
                    DispatchQueue.main.async(){
                        print("Failed")
                    }
                }
            }
        }
    }

    @IBAction func export(_ sender: Any) {
        let fileName = "Munki Catalog Browser Export"
        var csvText = "Display Name, Munki Name, Version, Catalog\n"
        for someApp in filteredAppsFound {
            var newLine = ""
            if let display_name = someApp.display_name {
                newLine = newLine + display_name
            }
            if let munkiName = someApp.name {
                newLine = newLine + ", " + munkiName
            }
            if let version = someApp.version {
                newLine = newLine + ", " + version
            }
            if let munkiCatalog = someApp.catalog {
                newLine = newLine + ", " + munkiCatalog + "\n"
            }
            csvText.append(newLine)
        }
        saveToLocation(fileName: fileName, data: csvText)
    }
}

extension ViewController: NSSearchFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        if let searchField = obj.object as? NSTextField {
            if searchField.stringValue.isEmpty {
                filteredAppsFound = appsFound
            } else {
                filteredAppsFound = appsFound.filter { ($0.display_name?.lowercased().contains(searchField.stringValue.lowercased()))!}
            }
            myTableView.reloadData()
        }
    }
}

extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
     }
}
