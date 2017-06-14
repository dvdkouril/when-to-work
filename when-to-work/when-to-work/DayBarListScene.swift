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
    let numOfDaysToLoad = 28
    
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
        //let numOfDaysToLoad = 28
        
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
            text.fontSize = 12
            text.position = CGPoint(x: 108, y: Int(startYPos) - index*20)
            text.horizontalAlignmentMode = .right
            text.verticalAlignmentMode = .bottom
            self.addChild(text)
        }
        
//        let line = SKShapeNode(rect: CGRect(x: 300, y: 100, width: 1, height: 500))
//        line.zPosition = 1.0
//        line.fillColor = SKColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        line.lineWidth = 0
//        
//        self.addChild(line)
        drawTimeline()
    }
    
    func drawText(textToDraw: String, pos : CGPoint, size: CGFloat) {
        let text = SKLabelNode(fontNamed: "Avenir Next")
        text.text = textToDraw
        text.fontSize = size
        text.position = pos
        text.horizontalAlignmentMode = .left
        text.verticalAlignmentMode = .bottom
        self.addChild(text)
    }
    
    func drawRectAt(scene : SKScene, pos : CGPoint, size : CGSize, col : SKColor, zPosition: CGFloat = 0.0) {
        let rect = SKShapeNode(rectOf: size)
        rect.fillColor = col
        rect.position = CGPoint(x: pos.x + size.width / 2, y: pos.y + size.height / 2)
        rect.lineWidth = 0
        rect.zPosition = zPosition
        
        scene.addChild(rect)
    }
    
    func drawTimeline() {
        
        //let startYPos = (self.scene?.size.height)! - 40
        let textYPos = (self.scene?.size.height)! - 20
        let startYPos = 20
        let barHeight = CGFloat(self.numOfDaysToLoad * 20) - 10
        
        // 0:00 line
        drawRectAt(scene: self,
                   pos: CGPoint(x: 120, y: startYPos),
                   size: CGSize(width: 1, height: barHeight),
                   col: SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0),
                   zPosition: 1.0)
        drawText(textToDraw: "0:00", pos: CGPoint(x: 110, y: textYPos), size: 10)
        
        // 6:00 line
        drawRectAt(scene: self,
                   pos: CGPoint(x: 263, y: startYPos),
                   size: CGSize(width: 1, height: barHeight),
                   col: SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0),
                   zPosition: 1.0)
        drawText(textToDraw: "6:00", pos: CGPoint(x: 253, y: textYPos), size: 10)
        
        // 12:00 line
        drawRectAt(scene: self,
                   pos: CGPoint(x: 407, y: startYPos),
                   size: CGSize(width: 1, height: barHeight),
                   col: SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0),
                   zPosition: 1.0)
        drawText(textToDraw: "12:00", pos: CGPoint(x: 394, y: textYPos), size: 10)
        
        // 18:00 line
        drawRectAt(scene: self,
                   pos: CGPoint(x: 550, y: startYPos),
                   size: CGSize(width: 1, height: barHeight),
                   col: SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0),
                   zPosition: 1.0)
        drawText(textToDraw: "18:00", pos: CGPoint(x: 537, y: textYPos), size: 10)
        
        // 0:00 line
        drawRectAt(scene: self,
                   pos: CGPoint(x: 693, y: startYPos),
                   size: CGSize(width: 1, height: barHeight),
                   col: SKColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0),
                   zPosition: 1.0)
        drawText(textToDraw: "0:00", pos: CGPoint(x: 684, y: textYPos), size: 10)
    }
}
