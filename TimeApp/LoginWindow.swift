//
//  LoginWindow.swift
//  TimeTime
//
//  Created by medidi vv satyanarayana murty on 02/02/16.
//  Copyright © 2016 Medidi vv satyanarayana murty. All rights reserved.
//

import Cocoa

let Keychain_keyName = "password"

class LoginWindow: NSWindowController
{
    @IBOutlet var userName: NSTextField!
    @IBOutlet var password: NSSecureTextField!
    @IBOutlet var loginButton: NSButton!
    @IBOutlet var indicator: NSProgressIndicator!
    
    
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    let keyChain = KeychainSwift()

    var timeSheetLayout:TimeSheetWindow? = nil
    var forgotPassword:ForgotPasswordWindow? = nil
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        {
            userName.stringValue = storedUsername as String
            loginButton.title = "LogIn"
            loginButton.tag = loginButtonTag
        }
        else
        {
             print(" No user Found ")
             loginButton.title = "Create"
             loginButton.tag = createLoginButtonTag
        }
    }
    
    override var windowNibName:String
    {
        return "LoginWindow"
    }
    
    @IBAction func resetFields(sender: NSButton)
    {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("username")
        keyChain.delete(Keychain_keyName)
        password.stringValue = ""
        userName.stringValue = ""
        loginButton.title = "Create"
        loginButton.tag = createLoginButtonTag
    }
    
    @IBAction func forgotPassword(sender: NSButton)
    {
        self.window?.close()
        let forgot = ForgotPasswordWindow(windowNibName: "ForgotPasswordWindow")
        forgot.showWindow(self)
        forgotPassword = forgot
    }
    
    
    @IBAction func login(sender: NSButton)
    {
        if sender.tag == loginButtonTag
        {
            if (userName.stringValue != "" && password.stringValue != "")
            {
                if checkLogin(userName.stringValue, password: password.stringValue)
                {
                    indicator.startAnimation(true)
                    sleep(2)
                    let alert = NSAlert()
                    alert.messageText = "Success"
                    alert.informativeText = "Successfully Login"
                    alert.runModal()
                    password.stringValue = ""
                    self.window?.close()
                    let time = TimeSheetWindow(windowNibName: "TimeSheetWindow")
                    time.showWindow(self)
                    timeSheetLayout = time
                }
                else
                {
                    let alert = NSAlert()
                    alert.messageText = "Error"
                    alert.informativeText = "Entered Wrong Password "
                    password.stringValue = ""
                    alert.runModal()
                }
                
            }
            else
            {
                let alert = NSAlert()
                alert.messageText = "Error"
                alert.informativeText = "Password Should not be Empty "
                alert.runModal()
            }
        }
        else
        {
            if (userName.stringValue == "" || password.stringValue == "")
            {
                let alert = NSAlert()
                alert.messageText = "Error"
                alert.informativeText = " Creation Failed "
                alert.informativeText = "All Fields Required"
                alert.runModal()
                return
            }
            else
            {
                let hasKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
                if hasKey == false
                {
                    NSUserDefaults.standardUserDefaults().setObject(userName.stringValue, forKey: "username")
                }
                keyChain.set(password.stringValue, forKey: Keychain_keyName)
                if (password.stringValue.characters.count > 6 )
                {
                    validate(Validation.ispassword(password))
                    
                    let alert = NSAlert()
                    alert.messageText = "Password strong"
                    alert.messageText = "Success"
                    alert.informativeText = "Successfully Created"
                    alert.runModal()
                    password.stringValue = ""
                    
                    loginButton.title = "LogIn"
                    loginButton.tag = loginButtonTag
                }
                else
                {
                    let alert = NSAlert()
                    alert.messageText = "Password weak"
                    alert.informativeText = "Password should be of minimum 6 characters,with atleast one Uppercase letter , One digit and One special character"
                    alert.runModal()
                    password.stringValue = ""
                }
            }
        }
    }

    func checkLogin(username: String, password: String ) -> Bool
    {
        if (password == keyChain.get (Keychain_keyName)) && username == (NSUserDefaults.standardUserDefaults().valueForKey("username") as? String)!
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func validate(validateError:ValidationTimeError)
    {
        switch validateError
        {
            case .Password:
                
                let alert = NSAlert()
                alert.messageText = "Warning "
                alert.informativeText = "InvalidPassword "
                alert.runModal()
            
            default:
                
                print("Success")
        }
    }
}

  

