//
//  ENScoreScene.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 23/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
 
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
        
        let mainMenuScene = SKScene(fileNamed: "ENMainMenuScene")
        mainMenuScene?.scaleMode = .aspectFill
        let transitionReveal = SKTransition.fade(withDuration: 0.5)
        self.scene?.view?.presentScene(mainMenuScene!, transition: transitionReveal)
        
    }

}
