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
    var visualizationWindow: NSWindowController!
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let apiKey = keyTextField.stringValue
        print("Preparing for segue: apiKey = \(apiKey)")
        
        let visWindowController = segue.destinationController as! NSWindowController
        let visualizationController = visWindowController.contentViewController as! ViewController
        visualizationController.apiKey = apiKey
    }
    
//    @IBAction func SubmitButtomPushed(_ sender: Any) {
//        
//        let apiKeyStr = keyTextField.stringValue
//        print("Submit key button pushed. Value = \(apiKeyStr)")
//        
//        let newWin = NSWindow()
//        //visualizationWindow = NSWindowController()
//        visualizationWindow = NSWindowController(window: newWin)
////        visualizationWindow.contentViewController = ViewController()
//        visualizationWindow.window?.contentViewController = ViewController()
//        visualizationWindow.showWindow(nil)
//        //visualizationWindow.window?.makeMain()
//    }
}
