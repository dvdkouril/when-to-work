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
    let numOfDaysToLoad = 7
    var offsetFromTop : CGFloat?
    var showingWeek = 0
    
    override func didMove(to view: SKView) {
        self.backgroundColor = NSColor(calibratedRed: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
        self.isUserInteractionEnabled = true
        //populateSceneWithDayBars()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        //print("DayBarListScene::update() called")
        
    }
    
//    override func touchesBegan(with event: NSEvent) {
//        print("touches")
//    }
    override func mouseDown(with event: NSEvent) {
        print("touch")
        
        let touchedNodes = self.nodes(at: event.location(in: self))
        if touchedNodes.count <= 0 {
            return
        }
        let touchedNode = touchedNodes[0]
        
        if touchedNode.name == "Left Arrow" {
            self.removeAllChildren()
            showingWeek += 1
        } else if touchedNode.name == "Right Arrow" {
            self.removeAllChildren()
            showingWeek -= 1
        }
        
        populateSceneWithDayBars(weekIndex: showingWeek)
    }
    
    func populateSceneWithDayBars(weekIndex : Int = 0) {
        let calendar = NSCalendar.current
        //let firstWeekday = calendar.firstWeekday
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        //~ Arrows
//        let a = SKSpriteNode(imageNamed: "arrow-left")
//        a.position = CGPoint(x: 100, y: 100)
//        self.addChild(a);
        
        //let leftArrow = ArrowNode(rectOf: CGSize(width: 25, height: 25))
        let leftArrow = ArrowNode(imageNamed: "arrow-left-white")
        leftArrow.size = CGSize(width: 25, height: 25)
        //leftArrow.fillColor = .white
        leftArrow.position = CGPoint(x: 25, y: (self.scene?.size.height)! - 38)
        leftArrow.name = "Left Arrow"
        self.addChild(leftArrow)
        
        //let rightArrow = ArrowNode(rectOf: CGSize(width: 25, height: 25))
        let rightArrow = ArrowNode(imageNamed: "arrow-right-white")
        rightArrow.size = CGSize(width: 25, height: 25)
        //rightArrow.fillColor = .white
        rightArrow.position = CGPoint(x: 420, y: (self.scene?.size.height)! - 38)
        rightArrow.name = "Right Arrow"
        self.addChild(rightArrow)
        
        
        //~ Find the latest Monday
        var components = DateComponents()
        components.weekday = 3
        let lastMonday = calendar.nextDate(after: today, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)
        
        let mondayOfWeekWeWant = calendar.date(byAdding: .day, value: -7 * weekIndex, to: lastMonday!)
        let weekOfYear = calendar.component(.weekOfYear, from: mondayOfWeekWeWant!)
        
        //~ Title
        let titlePos = CGPoint(x: 50, y: (self.scene?.size.height)! - 50)
        drawText(textToDraw: "Week " + String(weekOfYear) + " of the Year 2017", pos: titlePos, size: 30)

        
        self.offsetFromTop = 100
        let startYPos = (self.scene?.size.height)! - offsetFromTop!
        for index in 0..<numOfDaysToLoad {
            let currentBarDate = calendar.date(byAdding: .day, value: index, to: mondayOfWeekWeWant!)
            let dayStr = dateFormatter.string(from: currentBarDate!)
            let dayBar = DayBar(day: dayStr, apiKey: self.apiKey!, scene: self, index: index)
            dayBar.offsetFromTop = offsetFromTop
            dayBar.requestData()
            
            //~ title
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "EEE"
            weekdayFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let weekdayStr = weekdayFormatter.string(from: currentBarDate!)
            
            let text = SKLabelNode(fontNamed: "Avenir Next")
            text.text = "\(weekdayStr) \(dayStr)"
            text.fontSize = 12
            text.position = CGPoint(x: 108, y: Int(startYPos) - index*20)
            text.horizontalAlignmentMode = .right
            text.verticalAlignmentMode = .bottom
            self.addChild(text)

        }
        
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
    
    
    //~ pos is left bottom corner
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
        let textYPos = (self.scene?.size.height)! - self.offsetFromTop! + 20
        let barHeight = CGFloat(self.numOfDaysToLoad * 20) - 10
        let startYPos = (self.scene?.size.height)! - self.offsetFromTop! - barHeight + 10
        
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
