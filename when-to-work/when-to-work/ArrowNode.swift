//
//  ArrowNode.swift
//  when-to-work
//
//  Created by David Kouril on 15/07/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import Foundation
import SpriteKit

class ArrowNode : SKShapeNode {
        
    override func touchesBegan(with event: NSEvent) {
        super.touchesBegan(with: event)
        
        print("arrow touched")
    }
}
