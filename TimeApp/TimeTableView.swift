 //
 //  TimeTableView.swift
 //  TimeDragApplication
 //
 //  Created by vedashree k on 02/02/16.
 //  Copyright © 2016 vedashree k. All rights reserved.
 //
 
 import Cocoa
 
 class TimeTableView: NSWindowController
 {
   
    
    @IBOutlet var myWindow: NSWindow!
    
    var login:LoginWindow?
    let submitButtonTag = 0
    let withdrawButtonTag = 1
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var submitButton: NSButton!
    
    var mouseLocation: NSPoint
    {
        return NSEvent.mouseLocation()
    }

    var locationOfChangeTap: CGPoint = CGPoint.zero
    var locationX: CGPoint = CGPoint.zero
    var hr: Int?
    var min: Int?
    var amPm: String?
    var rowNum: Int?
    var endTime: String?
    var startTime: String?
    var col: Int?
    var row: Int?
    var cell: NSRect?
    var height : CGFloat = 0
    var y : CGFloat = 0
    var myViews = [NSView]()
    var layerOnA :NSView?
    var myButton:NSButton?
    var flag = true
    var location: CGPoint = CGPoint.zero
    var scrollVar = 0
    
    @IBOutlet weak var myTableView: NSTableView!
    
    override var windowNibName: String?
        {
        return "TimeTableView"
    }
    
    var timeArray : Array<String> = ["12AM","1AM","2AM","3AM","4AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12PM"]
    
    
    
    
    func tableView(tableView: NSTableView,
        shouldSelectRow row: Int) -> Bool
    {
            return false
    }
    
    func tableView(tableView: NSTableView,
        heightOfRow row: Int) -> CGFloat
    {
            return 100
    }
    
    
    
    @IBAction func draggingOnTableView(sender: NSPanGestureRecognizer)
    {
        
        
        if sender.state == NSGestureRecognizerState.Began
        {
            
            location = sender.locationInView(myTableView)
            layerOnA = NSView()
            
            locationX = sender.locationInView(scrollView.contentView)
            getCellFrame()
            startTime = giveTime()
         
        }
        
        
        locationOfChangeTap = sender.locationInView(myTableView)
        drawDragView()
        
        
        if layerOnA?.frame.size.height>0 && sender.state == NSGestureRecognizerState.Ended {
            height=round(height/25)*25
            layerOnA?.frame.size.height = height
            
            location = NSMakePoint(location.x,location.y + (layerOnA?.frame.size.height)!)
//            location=sender.locationInView(myTableView)
            getCellFrame()
            endTime = giveTime()
            
            createTextField()
            createCloseButton()
            
            myViews.append(layerOnA!)
                        
            height = 0
        }
        
    }
    
    ////////////////////////////////////////////////////////
    
    var  Brown: Float = 0.5
    var  yellow: Float = 0.5
    let alpha: Float = 1.0
    
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        
        let view:NSView
        if tableColumn?.identifier == "tail"
        {
            view = myTableView.makeViewWithIdentifier("head", owner: self)!
        }
        else
        {
            view = myTableView.makeViewWithIdentifier("1", owner: self)!
        }
        
        if tableColumn?.identifier == "1"
        {
            view.wantsLayer = true
            // view.layer?.backgroundColor = NSColor.brownColor().CGColor
            view.layer?.backgroundColor = NSColor(hue: 0.1, saturation: 0.2, brightness: 2.3, alpha: 3.0).CGColor
        }
        
        if tableColumn?.identifier == "2"
        {
            view.wantsLayer = true
            //view.layer?.backgroundColor = NSColor.yellowColor().CGColor
            view.layer?.backgroundColor = NSColor(hue: 0.2, saturation: 0.1, brightness: 2.3, alpha: 3.0).CGColor
        }
        if tableColumn?.identifier == "3"
        {
            view.wantsLayer = true
            // view.layer?.backgroundColor = NSColor.purpleColor().CGColor
            view.layer?.backgroundColor = NSColor(hue: 0.6, saturation: 0.1, brightness: 2.3, alpha: 3.0).CGColor
        }
        
        
        return view
    }

    ////////////////////////////////////////////////////////

    func drawDragView(){
            if location.x >= 105
            {
                
                
                layerOnA!.frame = NSMakeRect((cell?.origin.x)!,y,(cell?.size.width)!,height)
                
                checkOverlap()
                
                if flag
                {
                    
                    if locationOfChangeTap.y <= location.y + (layerOnA?.frame.size.height)!
                    {
                        height = height - 1
                    }
                    else
                    {
                        height = height + 1

                    }
                    

                    layerOnA!.wantsLayer = true
                    layerOnA!.layer!.backgroundColor = NSColor.blueColor().CGColor
                    layerOnA?.layer?.borderColor = NSColor.greenColor().CGColor
                    layerOnA?.layer?.borderWidth = 1
                    
//
                    
                    myTableView.addSubview(layerOnA!)
                    myTableView.addSubview(layerOnA!)
                    
                }
                scrollTableView()
                scrollVar++
                
            }
        }
    
    

    

    func scrollTableView()
    {
        if (layerOnA?.frame.origin.y)! - scrollView.contentView.bounds.origin.y
            + (layerOnA?.frame.size.height)! >= scrollView.contentView.bounds.size.height
        {
            scrollView.contentView.bounds.origin.y = scrollView.contentView.bounds.origin.y+30
            
            
        }
    }
    
    
    
    func checkOverlap(){
        if myViews.count != 0
        {
            
            for views in myViews
            {
                
                if CGRectIntersectsRect(NSMakeRect((layerOnA?.frame.origin.x)!, (layerOnA?.frame.origin.y)!, (layerOnA?.frame.size.width)!, (layerOnA?.frame.size.height)!+1),views.frame) || CGRectContainsPoint(views.frame, (layerOnA?.frame.origin)!){
                    
                    flag = false
                    break
                    
                }
                else{
                    flag = true
                    
                }
                
            }
        }
        
    }
    
    func getCellFrame(){
        row = myTableView.rowAtPoint(location)
        col = myTableView.columnAtPoint(location)
        
        
        cell = myTableView.frameOfCellAtColumn(col!, row: row!)
        if location.y >= cell!.origin.y && location.y < cell!.origin.y + 25{y = cell!.origin.y}
        if location.y >= cell!.origin.y + 25 && location.y < cell!.origin.y + 50{y = cell!.origin.y + 25}
        if location.y >= cell!.origin.y + 50 && location.y < cell!.origin.y + 75{y = cell!.origin.y + 50}
        if location.y >= cell!.origin.y + 75 && location.y < cell!.origin.y + 100{y = cell!.origin.y + 75
        }
        
    }
    
    func createTextField(){
        let myTextField = NSTextField(frame: NSMakeRect((layerOnA?.bounds.origin.x)!,(layerOnA?.bounds.height)!-25,82,25))
        myTextField.editable = false
        myTextField.backgroundColor = NSColor.darkGrayColor()
        myTextField.bordered = false
        myTextField.stringValue = startTime! + "-" + endTime!
        layerOnA!.addSubview(myTextField)
    }
    func createCloseButton(){
        myButton = NSButton()
        myButton!.frame = NSMakeRect((layerOnA?.bounds.width)!-20,(layerOnA?.bounds.height)!-25,20,25)
        
        myButton!.title = "✖︎"
        myButton!.action = Selector("buttonPressed:")
        myButton!.target = self
        
        layerOnA!.addSubview(myButton!)
        
    }
    
    func buttonPressed(sender : NSButton)
    {
        sender.superview?.removeFromSuperview()
        myViews.removeAtIndex(myViews.indexOf(sender.superview!)!)
    }
    
    
    
    
    func giveTime() -> String{
        
        if row < 13{
            
            if row != 0{
                hr = row
            }
            else{
                hr = 12
                
            }
            amPm = "a"
        }
        else{
            hr = row! - 12
            amPm = "p"
        }
        
        if location.y >= cell!.origin.y && location.y < cell!.origin.y + 25{ min = 0}
        if location.y >= cell!.origin.y + 25 && location.y < cell!.origin.y + 50{ min = 15}
        if location.y >= cell!.origin.y + 50 && location.y < cell!.origin.y + 75{ min = 30}
        if location.y >= cell!.origin.y + 75 && location.y < cell!.origin.y + 100{ min = 45
        }
        return String(hr!) + ":" + String(min!) + amPm!
        
    }
    
    @IBAction func logout(sender: NSButton)
    {
        let loginWindow = LoginWindow()
        loginWindow.showWindow(self)
        self.login = loginWindow
        window?.close()
    }
    
    @IBAction func submit(sender: NSButton)
    {
        if sender.tag == submitButtonTag
        {
            let alert = NSAlert()
            alert.messageText = "Done"
            alert.informativeText = "Weekly Report submitted successfully"
            alert.runModal()
            
            sender.tag == 1
            submitButton.title = "Withdraw"
            submitButton.tag = withdrawButtonTag
        }

    }
    
    
    
    
    
    
 }
