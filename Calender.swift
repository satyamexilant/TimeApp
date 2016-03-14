//
//  Calender.swift
//  TimeApp
//
//  Created by medidi vv satyanarayana murty on 14/03/16.
//  Copyright © 2016 medidi vv satyanarayana murty. All rights reserved.
//

import Cocoa

class Calender: NSViewController
{
@IBOutlet var calender: NSDatePicker!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        let todaysDate:NSDate = NSDate()
//        let nextDate:NSDate = NSDate()
//        let daysToAdd : Double = 1
//        let newDate = nextDate.dateByAddingTimeInterval(60*60*24*daysToAdd)
        calender.dateValue = todaysDate
//        if(newDate.isGreaterThan(todaysDate))
//        {
//            
//            NSStrikethroughStyleAttributeName
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "YYYY-MM-DD"
//            let stringValue = dateFormatter.stringFromDate(newDate)
//            let attributedString = NSMutableAttributedString(string: stringValue)
//            
//            print(attributedString.addAttribute(NSStrikethroughStyleAttributeName  , value: 1, range: NSMakeRange(0, attributedString.length)))
//        }
   
    
    }
    
   
}
