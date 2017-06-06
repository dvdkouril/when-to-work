//
//  DayBarListScene.swift
//  when-to-work
//
//  Created by David Kouril on 03/06/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import SpriteKit

class DayBarListScene: SKScene{
    
    var daysLoaded = [DayBar]()
    var apiKey: String? = nil
    
    override func didMove(to view: SKView) {
        self.backgroundColor = NSColor(calibratedRed: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        //populateSceneWithDayBars()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        //print("DayBarListScene::update() called")
        
    }
    
    func populateSceneWithDayBars() {
        let calendar = NSCalendar.current
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let startYPos = (self.scene?.size.height)! - 40
        let numOfDaysToLoad = 28
        
        for index in 0..<numOfDaysToLoad {
            let currentBarDate = calendar.date(byAdding: .day, value: -index, to: date)
            let dayStr = dateFormatter.string(from: currentBarDate!)
            //let dayBar = DayBar(day: dayStr, scene: self, index: index)
            let dayBar = DayBar(day: dayStr, apiKey: self.apiKey!, scene: self, index: index)
            dayBar.requestData()
            
            //let weekdayStr = getWeekdayString(weekday)
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "EEE"
            let weekdayStr = weekdayFormatter.string(from: currentBarDate!)
            
            // day title
            //drawText(dayStr, pos: CGPoint(x: 77, y: 59 + index*20), size: 10)
            let text = SKLabelNode(fontNamed: "Avenir Next")
            text.text = "\(weekdayStr) \(dayStr)"
            text.fontSize = 10
            text.position = CGPoint(x: 108, y: Int(startYPos) - index*20)
            //text.horizontalAlignmentMode = .Left
            text.horizontalAlignmentMode = .right
            text.verticalAlignmentMode = .bottom
            self.addChild(text)
        }

    }
}
