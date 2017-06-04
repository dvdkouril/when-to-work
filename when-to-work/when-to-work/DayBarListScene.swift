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
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .brown
        
        let size = CGSize(width: 0.1, height: 0.1)
        let rect = SKShapeNode(rectOf: size)
        rect.fillColor = .white
        rect.position = CGPoint(x: 0, y: 0)
        rect.lineWidth = 0
        
        self.addChild(rect)
        
        populateSceneWithDayBars()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        //print("DayBarListScene::update() called")
        
    }
    
    func populateSceneWithDayBars() {
        let calendar = NSCalendar.current
        let date = Date()
        var components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        for index in 0...6 {
            let currentBarDate = calendar.date(byAdding: .day, value: -index, to: date)
            components = calendar.dateComponents([.weekday, .day, .month, .year], from: currentBarDate!)
            let dayStr = "\(String(describing: components.year))-\(String(describing: components.month))-\(String(describing: components.day))"
            
            //let dayDataBar = DayBar(day: dayStr, scene: self, yPos: offset + index*20, dayIndex: index)
            let dayBar = DayBar(day: dayStr, scene: self, index: index)
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
            text.position = CGPoint(x: 108, y: 63 + index*20)
            //text.horizontalAlignmentMode = .Left
            text.horizontalAlignmentMode = .right
            text.verticalAlignmentMode = .bottom
            self.addChild(text)
        }

    }
}
