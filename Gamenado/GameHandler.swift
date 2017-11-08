//
//  GameHandler.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 17/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit

class GameHandler {
    
    // Variabili
    var money: Int32 = 0
    var followers: Int32 = 0
    var progettoAttivo: [String:Int] = ["Block1":0, "Block2":0, "Block3":0, "Block4":0]
    
    private static var sharedInstance: GameHandler = {
        let instance = GameHandler()
        return instance
    }()
    
    class func shared() -> GameHandler {
        return sharedInstance
    }
    
    /*
    class var sharedInstance: GameHandler {
        struct Singleton {
            static let instance = GameHandler()
        }
        
        return Singleton.instance
    }
     */
    
    init() {
        money = 0
        followers = 0
        progettoAttivo = ["Block1":0, "Block2":0, "Block3":0, "Block4":0]
    }

    
}
