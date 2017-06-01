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
    
    func requestData() {
        //Alamofire.requ
        Alamofire.request("https://www.rescuetime.com/anapi/data").responseJSON { response in
            print(response.response)
        }
    }
    
}
