//
//  SubmitKeyViewController.swift
//  when-to-work
//
//  Created by David Kouril on 05/06/2017.
//  Copyright © 2017 David Kouřil. All rights reserved.
//

import Foundation
import Cocoa

class SubmitKeyViewController: NSViewController {
    
    @IBOutlet weak var keyTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.window?.setFrame(NSRect(x: 0, y: 0, width: 480, height: 250), display: true, animate: true)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        var apiKey = ""
        if segue.identifier == "UseMineApiKey" {
            apiKey = "B63oAq3AYNvn6IxOqvGzGE3CmmVFsxID3OCPs1Pe"
        } else {
            apiKey = keyTextField.stringValue
        }
        print("Preparing for segue: apiKey = \(apiKey)")
        
        let visWindowController = segue.destinationController as! NSWindowController
//        visWindowController.window?.setFrame(NSRect(x: 0, y: 0, width: 480, height: 250), display: true, animate: true)
        let visualizationController = visWindowController.contentViewController as! ViewController
        visualizationController.apiKey = apiKey
        let sc = visualizationController.skView.scene as? DayBarListScene
        sc?.apiKey = apiKey
        sc?.populateSceneWithDayBars()
    }
}
