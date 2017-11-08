//
//  ENOperatoreModel.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 10/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class ENOperatoreModel: SKSpriteNode {

    // Costanti
    
    // Variabili
    private var floorAssignment: Int = 0
    private var floorBlock: SKSpriteNode? = nil
    
    // Immagini
    private let operatoreAtlas = SKTextureAtlas(named: "Operatore")
    
    //Propietà
    var isEnabled: Bool = true {
        didSet {
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(layout: Int) {
    
        let texture = operatoreAtlas.textureNamed("Tiny\(String(format: "%02d", layout))")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
    }

    func setLayout(layout: Int) {
        
    }
    
    func setAnimazione(animazione: String) {
        
    }

    func assignFloor(floorBlockSprite: SKSpriteNode, atFloor: Int) {
        floorBlock = floorBlockSprite
        floorAssignment = atFloor        
        
        //floorBlock.addChild(self)
    }

}
