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
    let keyChain = KeychainSwift()
    
    @IBOutlet var userNameInForgot: NSTextField!
    
    override func windowDidLoad()
    {
        super.windowDidLoad()

    }
    
    @IBAction func submit(sender: NSButton)
    {
        if userNameInForgot.stringValue != ""
        {
            if (checkLogin(userNameInForgot.stringValue, password: Keychain_keyName))
            {
                let username = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
                let password = keyChain.get("password")
                
                let alert = NSAlert()
                alert.messageText = "Data"
                alert.informativeText = "UserName is \(username!) and password is \(password!)"
                alert.runModal()
                
                window?.close()
                let loginWindow = LoginWindow()
                loginWindow.showWindow(self)
                self.login = loginWindow
            }
            else
            {
                let alert = NSAlert()
                alert .messageText = "Error"
                alert.informativeText = "Invalid UserName"
                alert.runModal()
                userNameInForgot.stringValue = ""
            }
        }
        else
        {
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = "UserName should not be Empty"
            alert.runModal()
            
        }
    }
    func checkLogin(username: String, password: String ) -> Bool
    {
        
        if (password == keyChain.get (Keychain_keyName)) || username == (NSUserDefaults.standardUserDefaults().valueForKey("username") as? String)!
        {
            return true
        }
        else
        {
            return false
        }
    }
    
  
}
