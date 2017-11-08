//
//  ENMainMenuScene.swift
//  Gamenando2
//
//  Created by Giovanni Tirico on 23/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

class ENMainMenuScene: SKScene {

    // Immagini
    private let buttonsAtlas = SKTextureAtlas(named: "Buttons")

    
    
    override func didMove(to view: SKView) {

        // Inizializza sfondo
        backgroundColor = UIColor.green

        // Inizializza i pulsanti
        InitButtons()

    }
    
    func InitButtons() {
        
        // Start Button
        let startButton = self.childNode(withName: "StartButton") as! ENButtonNode
        startButton.setTexture(normalTexture: buttonsAtlas.textureNamed("PulsanteDefault"),
                               selectedTexture: buttonsAtlas.textureNamed("PulsanteSelected"),
                               disabledTexture: buttonsAtlas.textureNamed("PulsanteDisabled"),
                               testo: "Gioca")
        startButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENMainMenuScene.startBtnTap))

        // Options Button
        let optionsButton = self.childNode(withName: "OptionsButton") as! ENButtonNode
        optionsButton.setTexture(normalTexture: buttonsAtlas.textureNamed("PulsanteDefault"),
                                 selectedTexture: buttonsAtlas.textureNamed("PulsanteSelected"),
                                 disabledTexture: buttonsAtlas.textureNamed("PulsanteDisabled"),
                                 testo: "Opzioni")
        optionsButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENMainMenuScene.optionsBtnTap))
        
        // Score Button
        let scoreButton = self.childNode(withName: "ScoreButton") as! ENButtonNode
        scoreButton.setTexture(normalTexture: buttonsAtlas.textureNamed("PulsanteDefault"),
                               selectedTexture: buttonsAtlas.textureNamed("PulsanteSelected"),
                               disabledTexture: buttonsAtlas.textureNamed("PulsanteDisabled"),
                               testo: "Score")
        scoreButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(ENMainMenuScene.scoreBtnTap))
    }
    
    func startBtnTap() {
        print("playBtnTap tapped")

        // Here for example you can do:
        let transition = SKTransition.fade(withDuration: 0.5)
        let nextScene = SKScene(fileNamed: "ENGameScene") as! ENGameClass

        //nextScene.scaleMode = .resizeFill
        self.scene?.view?.presentScene(nextScene, transition: transition)
        nextScene.isPlaying = true
    }
    
    func optionsBtnTap() {
        print("optionsBtnTap tapped")

        // Here for example you can do:
        let transition = SKTransition.fade(withDuration: 0.5)
        let nextScene = SKScene(fileNamed: "ENOptionsScene")
        
        //nextScene.scaleMode = .resizeFill
        self.scene?.view?.presentScene(nextScene!, transition: transition)
    }

    func scoreBtnTap() {
        print("scoreBtnTap tapped")
        
        // Here for example you can do:
        let transition = SKTransition.fade(withDuration: 0.5)
        let nextScene = SKScene(fileNamed: "ENScoreScene")
        
        //nextScene.scaleMode = .resizeFill
        self.scene?.view?.presentScene(nextScene!, transition: transition)
    }

}
