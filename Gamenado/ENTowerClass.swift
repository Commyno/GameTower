//
//  ENTowerClass.swift
//  Gamenado
//
//  Created by Giovanni Tirico on 28/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENTowerClass: SKNode {
    
    // Costanti
    private let numeroMaxPiani: Int = 10
    private let posizioneRoom = CGPoint(x: 53, y: 5)
    private let startPosizioneTower = CGPoint(x:45.0, y:39.0)
    
    // Variabili
    private var numeroPiani: Int = 0
    private var numeroDipendenti: Int = 0
    //private var towerRoomArray: [SKNode]
    
    // Immagini
    private let towerAtlas = SKTextureAtlas(named: "Tower")
    
    //Propietà
    var isEnabled: Bool = true {
        didSet {
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init() {
        super.init()

        //Inizializzo il bottone con una texture di default
        InitTower()
    
    }

    func InitTower() {

        // Restart from 0
        let posizioneXTowerBlock = self.startPosizioneTower.x
        var posizioneYTowerBlock = self.startPosizioneTower.y

        // Aggiungo il piano Basement
        let basementBlock = SKSpriteNode(texture: self.towerAtlas.textureNamed("Basement"))
        basementBlock.name = "Basement"
        basementBlock.anchorPoint = CGPoint.zero
        basementBlock.position = CGPoint(x: posizioneXTowerBlock,
                                         y: posizioneYTowerBlock)
        self.addChild(basementBlock)
        posizioneYTowerBlock += basementBlock.size.height
        
        // Aggiungo il piano HALL
        let hallBlock = SKSpriteNode(texture: self.towerAtlas.textureNamed("Hall"))
        hallBlock.name = "Hall"
        hallBlock.anchorPoint = CGPoint.zero
        hallBlock.position = CGPoint(x: posizioneXTowerBlock,
                                     y: posizioneYTowerBlock)
        self.addChild(hallBlock)
        posizioneYTowerBlock += hallBlock.size.height
        
        // Aggiungo Piano in costruzione
        let floorBlock = SKSpriteNode(texture: self.towerAtlas.textureNamed("Floor"))
        floorBlock.anchorPoint = CGPoint.zero
        floorBlock.name = "FloorInCostruzione"
        floorBlock.position = CGPoint(x: posizioneXTowerBlock,
                                      y: posizioneYTowerBlock)
        self.addChild(floorBlock)
        
        // Aggiungo il modello
        let modelloFloorBlock = ENBlockClass(modello:ENBlockClass.ENModelliStanza.InCostruzione)
        modelloFloorBlock.name = "BlockInCostruzione"
        modelloFloorBlock.position = CGPoint(x: posizioneXTowerBlock + 54,
                                             y: posizioneYTowerBlock)
        self.addChild(modelloFloorBlock)
        posizioneYTowerBlock += modelloFloorBlock.size.height

        // Aggiungo il piano ROOF
        let roofBlock = SKSpriteNode(texture: self.towerAtlas.textureNamed("Roof"))
        roofBlock.name = "Roof"
        roofBlock.anchorPoint = CGPoint.zero
        roofBlock.position = CGPoint(x: posizioneXTowerBlock,
                                     y: posizioneYTowerBlock)
        self.addChild(roofBlock)
        
        posizioneYTowerBlock += roofBlock.size.height

    }
    
    func addFloor(modello: ENBlockClass.ENModelliStanza) {

        let pianoInCostruzioneNode = (self.childNode(withName: "FloorInCostruzione") as? SKSpriteNode)!
        let bloccoInCostruzioneNode = (self.childNode(withName: "BlockInCostruzione") as? SKSpriteNode)!

        // Aggiungo un piano
        numeroPiani += 1
        let nomePiano = "Floor\(numeroPiani)"
        let nomeBlocco = "Block\(numeroPiani)"
        
        // Aggiungo un piano
        let floorBlock = SKSpriteNode(texture: self.towerAtlas.textureNamed("Floor"))
        floorBlock.anchorPoint = CGPoint.zero
        floorBlock.name = nomePiano
        floorBlock.position = pianoInCostruzioneNode.position
        self.addChild(floorBlock)
        
        // Aggiungo il modello
        let modelloFloorBlock = ENBlockClass(modello: modello)
        modelloFloorBlock.name = nomeBlocco
        modelloFloorBlock.position = bloccoInCostruzioneNode.position
        self.addChild(modelloFloorBlock)
        
        // Imposto gli eventi del piano
        modelloFloorBlock.setAction(target: self, triggerEvent: .OnCompleteProgressBar, action: #selector(ENTowerClass.onCompleteProgressBar))
        
        // Sposto i piani soprastanti
        pianoInCostruzioneNode.position.y = pianoInCostruzioneNode.position.y + floorBlock.size.height
        bloccoInCostruzioneNode.position.y = bloccoInCostruzioneNode.position.y + modelloFloorBlock.size.height

        let roofFloor = (self.childNode(withName: "Roof") as? SKSpriteNode)!
        roofFloor.position.y = roofFloor.position.y + floorBlock.size.height
        
    }

    func removeFloor() {

    }
    
    func onCompleteProgressBar(sender:AnyObject){
        if let blocco = sender as? ENBlockClass {
            switch blocco.contributoBlocco {
            case 1...4:
                GameHandler.shared().progettoAttivo[blocco.name!] = GameHandler.shared().progettoAttivo[blocco.name!]! + 1
            default:
                return
            }
        }
    }
    
    func update(currentTime: TimeInterval) {
        if(!isEnabled) {
            return
        }
        
        self.enumerateChildNodes(withName: "//Block*") { (nodo, _) in
            if let block = nodo as? ENBlockClass {
                block.update(currentTime: currentTime)
            }
        }
    }

}
