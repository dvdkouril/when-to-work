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
    var apiKey: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.view.window?.setFrame(NSRect(x: 0, y: 0, width: 800, height: 300), display: true, animate: true)
        self.view.setFrameSize(NSSize(width: 800, height: 270))
        
        let scene = DayBarListScene(size: view.frame.size)
        scene.apiKey = self.apiKey
        scene.scaleMode = .fill
        if let view = self.skView {
            view.presentScene(scene)
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
}

