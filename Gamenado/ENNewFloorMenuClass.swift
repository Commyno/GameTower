//
//  ENNewFloorMenuClass.swift
//  Gamenado
//
//  Created by Giovanni Tirico on 05/11/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENNewFloorMenuClass: SKNode {

    // Immagini
    private let buttonsAtlas = SKTextureAtlas(named: "Buttons")
    private let backgroundAtlas = SKTextureAtlas(named: "Backgrounds")
    private let titoliAtlas = SKTextureAtlas(named: "Titoli")
    private let menuNewFloorAtlas = SKTextureAtlas(named:"MenuNewFloor")
    
    // Variabili
    //private var menuSize: CGSize = CGSize(width: 100, height: 100)

    var scrollView: ENScrollView
    let scrollingNode = SKNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        scrollView = ENScrollView(frame: CGRect(x: 3, y: 1, width: 320, height: 428),
                                  scrollingNode: scrollingNode,
                                  direction: ENScrollView.ScrollDirection.horizontal)
        scrollView.zPosition = 10

        super.init()
        
        addChild(scrollView)

        // Abilito l'interazione utente
        self.isUserInteractionEnabled = false
        self.alpha = 0
        // Inserisco lo sfondo
        let background = SKSpriteNode(texture: backgroundAtlas.textureNamed("BackgroundMenuGame"),
                                      color: UIColor.clear, size: backgroundAtlas.textureNamed("BackgroundMenuGame").size())
        print(backgroundAtlas.textureNamed("BackgroundMenuGame").size())
        background.zPosition = -1
        addChild(background)
        
        // Inserisco il titolo
        let titolo = SKSpriteNode(texture: titoliAtlas.textureNamed("NuovaStanza"),
                                  color: UIColor.clear, size: titoliAtlas.textureNamed("NuovaStanza").size())
        titolo.position = CGPoint(x: 0,
                                  y: (background.size.height / 2) - titolo.size.height - 30)
        titolo.zPosition = 1
        addChild(titolo)
        
        // Inserisco i pulsanti
        let chiudiButton = ENButtonNode()
        chiudiButton.setTexture(normalTexture: buttonsAtlas.textureNamed("BottoneMenuPopUpDefault"),
                                selectedTexture: buttonsAtlas.textureNamed("BottoneMenuPopUpSelected"),
                                disabledTexture: buttonsAtlas.textureNamed("BottoneMenuPopUpDefault"),
                                testo: "Chiudi")
        chiudiButton.position = CGPoint(x: 0, y: -195)
        chiudiButton.zPosition = 10
        chiudiButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENNewFloorMenuClass.closeMenu))
        addChild(chiudiButton)
        
    }
    
    func setPulsanti(){
        
    }
    
    func openMenu() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func closeMenu() {
        self.alpha = 0
        self.isUserInteractionEnabled = false
        //self.removeFromParent()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let node = self.nodes(at: location) as! SKSpriteNode
            if (node.name == "ScrollingNode") {
                scrollView.touchesBegan(touches: touches, withEvent: event)
            }
        }
            //let location = t.location(in: self)
            //let previousLocation = t.previousLocation(in: self)
            //let diff = location.y - previousLocation.y
            
            /*
             //camera?.position.x += location.x - previousLocation.x
             if ( (camera?.position.y)! + diff >= minPosition &&
             (camera?.position.y)! + diff <= maxPosition ) {
             camera?.position.y += diff
             }
             */
 }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
            //let location = t.location(in: self)
            //let previousLocation = t.previousLocation(in: self)
            //let diff = location.y - previousLocation.y
            
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
    }

    
}
