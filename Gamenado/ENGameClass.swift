//
//  ENGameClass.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 23/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENGameClass: SKScene {
    
    // Variabili
    var cameraNode: SKCameraNode = SKCameraNode()
    var hudNode: ENHUDClass = ENHUDClass()
    var torreNode: ENTowerClass = ENTowerClass()
    var newFloorMenu = ENNewFloorMenuClass()
    
    var isPlaying = false
    
    var minPosition: CGFloat = 0.0
    var maxPosition: CGFloat = 0.0

    // Costanti
    let gameHandler = GameHandler()

    
    override func sceneDidLoad() {
        
        // Inizializzo i dati del gioco
        gameHandler.followers = 0
        gameHandler.money = 0
        
    }
    
    override func didMove(to view: SKView) {

        // Inizializzo i dati del gioco
        gameHandler.followers = 0
        gameHandler.money = 0
        
        // Inizializzo la camera
        self.cameraNode = (self.childNode(withName: "//TheCamera") as? SKCameraNode)!
        self.camera = self.cameraNode
        self.cameraNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        minPosition = (self.camera?.position.y)!
        maxPosition = (self.camera?.position.y)! + ( self.frame.height * 3 )

        // Inizializzo HUB
        self.hudNode = (cameraNode.childNode(withName: "//ENHUD") as? ENHUDClass)!
        self.hudNode.setTotalMoney(value: 0)
        self.hudNode.setTotalFollowers(value: 0)
        
        // Inizializzo Torre
        //self.torreNode.position = CGPosition(x: , y:)
        self.torreNode.zPosition = 10
        self.addChild(self.torreNode)
        
        // Inizializzo i menu
        self.newFloorMenu.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.newFloorMenu.zPosition = 60
        addChild(self.newFloorMenu)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for t in touches {
            //let location = t.location(in: self)
            //let previousLocation = t.previousLocation(in: self)
            //let diff = location.y - previousLocation.y
            
            //camera?.position.x += location.x - previousLocation.x
            if ( (camera?.position.y)! + diff >= minPosition &&
                (camera?.position.y)! + diff <= maxPosition ) {
                camera?.position.y += diff
            }
        }
 */
        for t in touches {
            let location = t.location(in: self)
            
            for nodo in self.nodes(at: location) {
                if(nodo.name == "ScrollingNode"){
                    newFloorMenu.touchesMoved(touches, with: event)
                }
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
        for t in touches {
            let location = t.location(in: self)
            //let previousLocation = t.previousLocation(in: self)
            //let diff = location.y - previousLocation.y

            for nodo in self.nodes(at: location) {
                if(nodo.name == "BlockInCostruzione"){
                    newFloorMenu.openMenu()
                    
                    // Aggiungo i piani
                    //self.torreNode.addFloor(modello: ENBlockClass.ENModelliStanza.CodeDesign)
                }
                if(nodo.name == "ScrollingNode"){
                    newFloorMenu.touchesMoved(touches, with: event)
                    
                    // Aggiungo i piani
                    //self.torreNode.addFloor(modello: ENBlockClass.ENModelliStanza.CodeDesign)
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if(!isPlaying) {
            return
        }

        updateHubNode()

        // Aggiorno componenti
        torreNode.update(currentTime: currentTime)
        
    }
    
    func updateHubNode() {
        self.hudNode.setTotalMoney(value: gameHandler.money)
        self.hudNode.setTotalFollowers(value: gameHandler.followers)
    }
    
}
