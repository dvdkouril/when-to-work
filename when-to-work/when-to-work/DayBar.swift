//
//  DayBar.swift
//  when-to-work
//
//  Created by David Kouril on 01/06/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import Foundation
import SpriteKit
import Alamofire
import SwiftyJSON

class DayBar {
    
    var dayStamp: String?
    var isLoaded: Bool
    var dayIndex: Int?
    var scene: SKScene?
    var apiKey: String?
    var offsetFromTop: CGFloat?
    
    var timeFragments = [String:(TimeFragment, SKShapeNode?)]() // the shape node is a visual representation of this time fragment
    
    init() {
        dayStamp = nil
        isLoaded = false
        dayIndex = nil
        scene = nil
        apiKey = nil
    }
    
    init(day : String, apiKey : String, scene : SKScene, index : Int) {
        isLoaded = false
        dayStamp = day
        dayIndex = index
        self.scene = scene
        self.apiKey = apiKey
    }
    
    func requestData() {
        print("DayBar \(self.dayStamp!) loading started...")
        //let params = ["key"             : "B63oAq3AYNvn6IxOqvGzGE3CmmVFsxID3OCPs1Pe",
        let params = ["key"             : self.apiKey!,
                      "format"          : "json",
                      "perspective"     : "interval",
                      "restrict_begin"  : dayStamp!,
                      "restrict_end"    : dayStamp!,
                      "resolution_time" : "minute"]
        
        Alamofire.request("https://www.rescuetime.com/anapi/data",
                          parameters: params).responseJSON {
                            response in
                            
                            let json = JSON(response.result.value!)
                            
                            var numOfRecords = 0
                            for record in json["rows"] {
                                let activity = record.1[3].string!
                                let numberOfSeconds = record.1[1].intValue
                                let timeStartedStr = record.1[0].string!
                                let productivityScore = record.1[5].intValue
                                
                                //                                print("--------------------------")
                                //                                print(activity)
                                //                                print(numberOfSeconds)
                                //                                print(timeStarted)
                                //                                print(productivityScore)
                                
                                if self.timeFragments.index(forKey: timeStartedStr) == nil {
                                    self.timeFragments[timeStartedStr] = (TimeFragment(timeStamp: timeStartedStr), nil)
                                }
                                self.timeFragments[timeStartedStr]?.0.add(activity: activity, withTime: numberOfSeconds, withScore: productivityScore)
                                
                                numOfRecords += 1
                            }
                            //                            print("--------------------------")
                            //                            print("Number of records = " + String(numOfRecords))
                            print("DayBar \(self.dayStamp!) loading finished...\(String(numOfRecords)) time fragments downloaded")
                            self.isLoaded = true
                            
                            self.addBarToScene()
        }
    }
    
    func addBarToScene() {
        
        //var xOffset : CGFloat = (800 - 576) / 2
        let xOffset : CGFloat = 120
        // background rect (untracked time)
        let startYPos = (self.scene?.size.height)! - offsetFromTop!
        
        drawRectAt(scene: self.scene!, pos: CGPoint(x: xOffset, y: CGFloat(startYPos - CGFloat(self.dayIndex! * 20))), size: CGSize(width: 576, height: 10), col: SKColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0))
        
        if timeFragments.isEmpty {
            return
        }
        
        let sampleTimeStamp = timeFragments[timeFragments.startIndex].0 // pick the first record in directory, just to get
        // the same day date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let dayDate = dateFormatter.date(from: sampleTimeStamp)
        print(dateFormatter.string(from: dayDate!)) // this is how see the "correct" date
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: dayDate!)
        
        // reseting the time to start of the day
        components.hour = 0
        components.minute = 0
        components.second = 0
        var iteratingDate = calendar.date(from: components)
        
        components.hour = 23
        components.minute = 55
        components.second = 0
        let endDate = calendar.date(from: components)
        
        var i = 0
        
        while !(iteratingDate! == endDate!) { // bug: doesn't draw the last 5-min
            let itDateString = dateFormatter.string(from: iteratingDate!)
            let size = CGSize(width: 576 / 288, height: 10)
            
            //if timeFragments.indexForKey(itDateString) == nil { // no activity for this date
            if timeFragments.index(forKey: itDateString) == nil {
                // draw empty rect
                /*var color : SKColor
                 color = SKColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
                 
                 self.drawRectAt(scene, pos: CGPoint(x: CGFloat(xOffset + CGFloat(i) * size.width), y: CGFloat(self.barYPos)), size: size, col: color)*/
            } else { // some activities found
                // draw rect based on average productivity
                var color : SKColor
                
                let productivity = timeFragments[itDateString]?.0.weightedAverageOfActivities()
                
                switch productivity! {
                case -2...(-1):
                    // rgb: 202, 68, 68
                    color = SKColor(red: 0.79, green: 0.27, blue: 0.27, alpha: 1.0)
                case -1...0:
                    // rgb: 221, 211, 102
                    color = SKColor(red: 0.87, green: 0.83, blue: 0.4, alpha: 1.0)
                case 0...1:
                    // rgb 62, 161, 135
                    color = SKColor(red: 0.24, green: 0.63, blue: 0.53, alpha: 1.0)
                case 1...2:
                    // rgb 70, 221, 162
                    color = SKColor(red: 0.27, green: 0.87, blue: 0.64, alpha: 1.0)
                default:
                    color = SKColor.magenta
                }
                
                self.drawRectAt(scene: scene!, pos: CGPoint(x: CGFloat(xOffset + CGFloat(i) * size.width), y: CGFloat(startYPos - CGFloat(self.dayIndex! * 20))), size: size, col: color)
            }
            
            iteratingDate = calendar.date(byAdding: .second, value: 300, to: iteratingDate!) // jump 5 minutes (300 seconds) in time
            i += 1
        }
    }
    
    //~ pos is left bottom corner
    func drawRectAt(scene : SKScene, pos : CGPoint, size : CGSize, col : SKColor) {
        let rect = SKShapeNode(rectOf: size)
        rect.fillColor = col
        rect.position = CGPoint(x: pos.x + size.width / 2, y: pos.y + size.height / 2)
        rect.lineWidth = 0
        
        scene.addChild(rect)
    }
    
}
