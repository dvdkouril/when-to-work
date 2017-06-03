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
    
    var isLoaded = false
    var timeFragments = [String:TimeFragment]()
    
    func requestData() {
        let params = ["key"             : "B63oAq3AYNvn6IxOqvGzGE3CmmVFsxID3OCPs1Pe",
                      "format"          : "json",
                      "perspective"     : "interval",
                      "restrict_begin"  : "2017-05-01",
                      "restrict_end"    : "2017-05-30",
                      "resolution_time" : "minute"]
        
        Alamofire.request("https://www.rescuetime.com/anapi/data",
                          parameters: params).responseJSON {
                            response in
                            
                            let json = JSON(response.result.value)
                            
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
                                    self.timeFragments[timeStartedStr] = TimeFragment(timeStamp: timeStartedStr)
                                }
                                self.timeFragments[timeStartedStr]?.add(activity: activity, withTime: numberOfSeconds, withScore: productivityScore)
                                
                                numOfRecords += 1
                            }
                            //                            print("--------------------------")
                            //                            print("Number of records = " + String(numOfRecords))
                            self.isLoaded = true
        }
    }
    
    func drawBar() {
        
    }
    
}
