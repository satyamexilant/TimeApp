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
    
    
    let createButtonTag = 0
    let loginButtonTag = 1
    
    let keyChain = KeychainSwift()

    
    var forgotPassword:ForgotPasswordWindow? = nil
     var timeTableView: TimeTableView? 
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
             loginButton.tag = createButtonTag
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
        loginButton.tag = createButtonTag
    }
    
    @IBAction func forgotPassword(sender: NSButton)
    {
        self.window?.close()
        let forgot = ForgotPasswordWindow(windowNibName: "ForgotPasswordWindow")
        forgot.showWindow(self)
        forgotPassword = forgot
    }
    
<<<<<<< Updated upstream
=======
    func checkTextSufficientComplexity( text : String) -> Bool{
        
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluateWithObject(text)
        print("\(capitalresult)")
        
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluateWithObject(text)
        print("\(numberresult)")
        
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        
        let specialresult = texttest2.evaluateWithObject(text)
        print("\(specialresult)")
        
        return capitalresult && numberresult && specialresult
        
    }

>>>>>>> Stashed changes
    
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
                    
                    let timeTableView = TimeTableView()
                    self.timeTableView = timeTableView
                    timeTableView.window!.acceptsMouseMovedEvents = true
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
<<<<<<< Updated upstream
                keyChain.set(password.stringValue, forKey: Keychain_keyName)
                if (password.stringValue.characters.count > 6 )
                {
                    validate(Validation.ispassword(password))
                    
                    let alert = NSAlert()
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
=======
                
                // let alert = NSAlert()
//                alert.messageText =
            
                
                let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(userName.stringValue, forKey: "username")
                defaults.setObject(password.stringValue, forKey: "password")
                
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasPassword")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                keyChain.set(password.stringValue, forKey: Keychain_keyName)
                
                    if(password.stringValue.characters.count > 7)
                    {
                        if(checkTextSufficientComplexity(password.stringValue)){
                            let alert = NSAlert()
                            alert.messageText = "Password strong"
                            alert.runModal()
                        }
                        

                let alert1 = NSAlert()
                alert1.messageText = "Success"
                alert1.informativeText = "Successfully Created"
                alert1.runModal()
                password.stringValue = ""
                //userName.stringValue = ""
                //windowDidLoad()
                loginButton.title = "LogIn"
                loginButton.tag = loginButtonTag
                        }
                    else {
                        let alert = NSAlert()
                        alert.messageText = "Password weak"
                        alert.informativeText = "Password should be of minimum 6 characters. Enter atleast one Uppercase letter , One digit and One special character"
                        alert.runModal()
                         password.stringValue = ""
>>>>>>> Stashed changes
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

  

