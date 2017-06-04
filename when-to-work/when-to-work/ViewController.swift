//
//  ViewController.swift
//  when-to-work
//
//  Created by David Kouril on 31/05/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let scene = DayBarListScene()
        let scene = DayBarListScene(size: view.frame.size)
        scene.scaleMode = .fill
        if let view = self.skView {
            view.presentScene(scene)
            // 63, 171, 122
            //scene.backgroundColor = NSColor(calibratedRed: 63.0 / 255.0, green: 171.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

