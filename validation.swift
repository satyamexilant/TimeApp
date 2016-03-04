//
//  validation.swift
//  TimeLoginWindow
//
//  Created by medidi vv satyanarayana murty on 09/02/16.
//  Copyright © 2016 Medidi vv satyanarayana murty. All rights reserved.
//

import Cocoa


enum ValidationTimeError:ErrorType
{
    case EmptyString(NSTextField)
    case ContainsNumber(NSTextField)
    case ContainsNumberCharacters(NSTextField)
    case ContainsSpecialChar(NSTextField)
    case Success,InvalidEmailId,Password
}
    
class Validation: NSObject
{
        
    class func ispassword(UserTextField:NSTextField)->ValidationTimeError
    {
      if UserTextField.stringValue.isEmpty
      {
        return ValidationTimeError.EmptyString(UserTextField)
      }
      let passwordRegEx = "[A-Za-z0-9!@#$%^&*]+"
      let range = UserTextField.stringValue.rangeOfString(passwordRegEx, options: .RegularExpressionSearch)
      let result = range != nil ? ValidationTimeError.Success : ValidationTimeError.Password
      return result
    }
}
