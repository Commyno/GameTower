//
//  ENMenuGame.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 30/09/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class ENMenuGame: SKSpriteNode {

    // Immagini
    private let buttonsAtlas = SKTextureAtlas(named: "Buttons")
    private let backgroundsAtlas = SKTextureAtlas(named: "Backgrounds")
    private let titoliAtlas = SKTextureAtlas(named: "TitoliMenu")
    
    // Costanti
    
    // Variabili
    
    private let titoliMenu = SKTexture.init(imageNamed: "MenuGameTitoli")
    var posizione:[CGPoint] = []
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init() {
    
        //Inizializzo il bottone con una texture di default
        super.init(texture: backgroundsAtlas.textureNamed("BackgroundMenuGame"),
                   color: UIColor.clear,
                   size: backgroundsAtlas.textureNamed("BackgroundMenuGame").size())
        isUserInteractionEnabled = false

        // Titolo
        let titoloMenu = SKSpriteNode(texture: titoliAtlas.textureNamed("NuovaStanza"),
                                      color: UIColor.clear,
                                      size: titoliAtlas.textureNamed("NuovaStanza").size())
        titoloMenu.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 90)
        titoloMenu.zPosition = 1
        self.addChild(titoloMenu)

        /*
        //Quadro
        let dim = CGSize(width: 325, height: 432)
        let ss = SKSpriteNode(texture: nil, color: UIColor.white, size: dim)
        ss.zPosition = 0
        ss.position = CGPoint(x: self.frame.midX + 3, y: self.frame.midY - 1)
        self.addChild(ss)
        */
        
        /*
        // Sprite to scroll
        spriteToScroll = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 325, height: 432))
        spriteToScroll.anchorPoint = CGPoint.zero
        spriteToScroll.zPosition = 1
        spriteToScroll.position = CGPoint(x: 10, y: 100)
        self.addChild(spriteToScroll)
        */
        
        addPulsanti()
        
    }

    
    func addPulsanti() {
        
        if let menuPropertyListBundlePath = Bundle.main.path(forResource: "MenuPropertyList", ofType: "plist") {
            let itemsMenuPropertyList = NSArray(contentsOfFile: menuPropertyListBundlePath) as! [[String:AnyObject]]
            for item in itemsMenuPropertyList  {
                if (item["Nome"]?.description == "Nuova stanza") {
                    let elementi = item["Elementi"] as! [[String:AnyObject]]
                    for elemento in elementi {

                        if (elemento["Tipo"]?.description == "Pulsante") {
                            // Pulsante 1
                            let menuButton1 = ENPulsante(normalTexture: buttonsAtlas.textureNamed((elemento["PulsanteDefault"]?.description)!),
                                                         selectedTexture: buttonsAtlas.textureNamed((elemento["PulsanteSelected"]?.description)!),
                                                         disabledTexture: buttonsAtlas.textureNamed((elemento["PulsanteDisabled"]?.description)!),
                                                         testo: "")
                            let posX = CGFloat(NumberFormatter().number(from: (elemento["PosizioneX"]?.description)!)!)
                            let posY = CGFloat(NumberFormatter().number(from: (elemento["PosizioneY"]?.description)!)!)
                            menuButton1.position = CGPoint(x: posX, y: posY)
                            //menuButton1.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
                            menuButton1.zPosition = 1
                            self.addChild(menuButton1)
                        }
                    }
                }
            }
        }else{
            print("File MenuPropertyList.plist not found.")
        }
        
    }

    func addPulsantiera() {
        posizione.append(CGPoint(x: self.frame.midX - ( self.frame.width / 3),
                                 y: self.frame.midY + ( self.frame.height / 3)))
        posizione.append(CGPoint(x: self.frame.midX,
                                 y: self.frame.midY + ( self.frame.height / 3)))
        posizione.append(CGPoint(x: self.frame.midX + ( self.frame.width / 3),
                                 y: self.frame.midY + ( self.frame.height / 3)))
        posizione.append(CGPoint(x: self.frame.midX - ( self.frame.width / 3),
                                 y: self.frame.midY ))
        posizione.append(CGPoint(x: self.frame.midX,
                                 y: self.frame.midY ))
        posizione.append(CGPoint(x: self.frame.midX + ( self.frame.width / 3),
                                 y: self.frame.midY ))
        posizione.append(CGPoint(x: self.frame.midX - ( self.frame.width / 3),
                                 y: self.frame.midY - ( self.frame.height / 3)))
        posizione.append(CGPoint(x: self.frame.midX,
                                 y: self.frame.midY - (self.frame.height / 3)))
        posizione.append(CGPoint(x: self.frame.midX + ( self.frame.width / 3),
                                 y: self.frame.midY - ( self.frame.height / 3)))
        
        // Pulsante 1
        let menuButton1 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton1.position = posizione[0]
        //menuButton1.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton1.zPosition = 1
        menuButton1.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton1)
        
        // Pulsante 2
        let menuButton2 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton2.position = posizione[1]
        //menuButton2.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton2.zPosition = 1
        menuButton2.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton2)
        
        // Pulsante 3
        let menuButton3 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton3.position = posizione[2]
        //menuButton3.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton3.zPosition = 1
        menuButton3.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton3)
        
        // Pulsante 4
        let menuButton4 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton4.position = posizione[3]
        //menuButton4.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton4.zPosition = 1
        menuButton4.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton4)
        
        // Pulsante 5
        let menuButton5 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton5.position = posizione[4]
        //menuButton5.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton5.zPosition = 1
        menuButton5.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton5)
        
        // Pulsante 6
        let menuButton6 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton6.position = posizione[5]
        //menuButton6.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton6.zPosition = 1
        menuButton6.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton6)
        
        // Pulsante 7
        let menuButton7 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton7.position = posizione[6]
        //menuButton7.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton7.zPosition = 1
        menuButton7.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton7)
        
        // Pulsante 8
        let menuButton8 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton8.position = posizione[7]
        //menuButton8.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton8.zPosition = 1
        menuButton8.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton8)
        
        // Pulsante 9
        let menuButton9 = ENPulsante(normalTexture: buttonsAtlas.textureNamed("MenuPulsanteDefault"),
                                     selectedTexture: buttonsAtlas.textureNamed("MenuPulsanteSelected"),
                                     disabledTexture: buttonsAtlas.textureNamed("MenuPulsanteDisabled"),
                                     testo: "")
        menuButton9.position = posizione[8]
        //menuButton9.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENHud.menuBtnTap))
        menuButton9.zPosition = 1
        menuButton9.scale(to: CGSize(width: 70, height: 70))
        self.addChild(menuButton9)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches {        }
        let firstTouch = touches.first
        let positionInScene = firstTouch?.location(in: self)
        let previousPosition = firstTouch?.previousLocation(in: self)
        let translation = positionInScene! - previousPosition!
        
    }
    
}
