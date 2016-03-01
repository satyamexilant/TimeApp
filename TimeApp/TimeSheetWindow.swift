//
//  TimeSheetWindow.swift
//  TimeTime
//
//   Created by medidi vv satyanarayana murty on 02/02/16.
//  Copyright © 2016 Avnish kumar. All rights reserved.
//

import Cocoa

class TimeSheetWindow: NSWindowController {
    @IBOutlet var combobox: NSComboBox!
    var login:LoginWindow?

    override func windowDidLoad() {
        super.windowDidLoad()
       
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func comboBox(sender: AnyObject)
    {
        sender.selectedTag()
        window!.close()
        
        let loginWindow = LoginWindow()
        loginWindow.showWindow(self)
        self.login = loginWindow
    }
   }
