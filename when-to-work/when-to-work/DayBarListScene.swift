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
        let dayBar = DayBar()
        dayBar.requestData()
    }
    
    override func update(_ currentTime: TimeInterval) {
        print("DayBarListScene::update() called")
    }
}
