//
//  GameViewController.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 24/09/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inizializzo view base
        let sceneView = self.view as! SKView
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        sceneView.ignoresSiblingOrder = true
       
        let mainMenuScene = SKScene(fileNamed: "ENMainMenuScene")
        mainMenuScene?.scaleMode = .aspectFill
        let transitionReveal = SKTransition.fade(withDuration: 0.5)
        sceneView.presentScene(mainMenuScene!, transition: transitionReveal)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
