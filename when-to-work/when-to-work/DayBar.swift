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

class DayBar {
    
    var isLoaded = false
    
    func requestData() {
        let params = ["key"             : "B63oAq3AYNvn6IxOqvGzGE3CmmVFsxID3OCPs1Pe",
                      "format"          : "json",
                      "perspective"     : "interval",
                      "restrict_begin"  : "2017-05-29",
                      "restrict_end"    : "2017-05-30",
                      "resolution_time" : "minute"]
        
        Alamofire.request("https://www.rescuetime.com/anapi/data",
                          parameters: params).responseJSON { response in
            print(response.response)
        }
    }
    
    func drawBar() {
        
    }
    
}
