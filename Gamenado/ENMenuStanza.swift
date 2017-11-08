//
//  ENMenuStanza.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 13/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class ENMenuStanza: SKSpriteNode {
    
    // Costanti
    private let sizeMenu = CGSize(width: 750.0, height: 1334.0)
    
    // Variabili
    private var floorAssignment: Int = 0
    private var floorBlock: SKSpriteNode? = nil
    
    // Immagini
    private let menuAtlas = SKTextureAtlas(named: "Tower")
    //private let stanzaMenuAtlas = SKTextureAtlas(named: "StanzaMenu")
    
    //Propietà
    var isEnabled: Bool = false {
        didSet {
            if(self.isEnabled) {
                self.alpha = 100
            }else{
                self.alpha = 0
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(texture: nil, color: UIColor.clear, size: sizeMenu)
    }

    init(titoloMenu: String) {
        super.init(texture: nil, color: UIColor.clear, size: sizeMenu)
        
        self.name = "MenuStanza"
        
        // Titolo
        let titolo = SKSpriteNode(texture: menuAtlas.textureNamed("MenuTitoloStanza"),
                                  color: UIColor.clear,
                                  size: menuAtlas.textureNamed("").size())
        titolo.zPosition = 10
        titolo.position = CGPoint(x: self.frame.midX,
                                  y: self.frame.maxY - (menuAtlas.textureNamed("MenuBackground").size().height ) - 20)
        print(menuAtlas.textureNamed("MenuBackground").size())
        self.addChild(titolo)

        // Sfondo menu
        let backgroundMenu = SKSpriteNode(texture: menuAtlas.textureNamed("MenuBackground"),
                                  color: UIColor.clear,
                                  size: menuAtlas.textureNamed("").size())
        backgroundMenu.zPosition = 10
        backgroundMenu.position = CGPoint(x: self.frame.midX,
                                          y: self.frame.midY)
        self.addChild(backgroundMenu)
        
        // Pulsanti menu
        setPulsantiMenu()
        
        //Pulsante chiusura

        // Lo rendo non attivo
        self.alpha = 0
    }
    
    func setPulsantiMenu() {
        
    }
    
    func openMenu(){

        self.alpha = 100
        self.isEnabled = true
    }
    
    func closeMenu(){
        self.alpha = 0
        self.isEnabled = false
    }
    
}
