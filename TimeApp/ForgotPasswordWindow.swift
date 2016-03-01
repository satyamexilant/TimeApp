//
//  ForgotPasswordWindow.swift
//  TimeTime
//
//  Created by medidi vv satyanarayana murty on 02/02/16.
//  Copyright © 2016 Medidi vv satyanarayana murty. All rights reserved.//

import Cocoa

class ForgotPasswordWindow: NSWindowController
{
    var login:LoginWindow?
    @IBOutlet var userNameInForgot: NSTextField!
    
    override func windowDidLoad()
    {
        super.windowDidLoad()

    }
    
    
    @IBAction func submit(sender: NSButton)
    {
        
        if userNameInForgot.stringValue == ""
        {
          let alert = NSAlert()
          alert.messageText = "Error"
          alert.informativeText = " Enter Your UserName"
          alert.runModal()
        }
        else
        {
          
           let password = NSUserDefaults.standardUserDefaults().valueForKey("password") as? String
           let username = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
            
            let alert = NSAlert()
            alert.messageText = "Data"
            alert.informativeText = "UserName is \(username!) and password is \(password!)"
            alert.runModal()
            
            window?.close()
            let loginWindow = LoginWindow()
            loginWindow.showWindow(self)
            self.login = loginWindow
        }
    }
  
}
