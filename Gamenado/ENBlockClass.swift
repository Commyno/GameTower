//
//  ENBlockClass.swift
//  Gamenado
//
//  Created by Giovanni Tirico on 29/10/17.
//  Copyright © 2017 Giovanni Tirico. All rights reserved.
//

import SpriteKit
import GameplayKit

/*
class ENBlockEvent: UIEvent  {

    var senderName: String = ""
    var senderObject: AnyObject? = nil
    
    init(senderName: String, senderObject: AnyObject?) {
        self.senderName = senderName
        self.senderObject = senderObject
    }

}
*/

enum ENBlockActionType: Int {
    case OnCompleteProgressBar = 1,
    OnAddNewEnployer
}

class ENBlockClass: SKSpriteNode {
    
    // Costanti
    let spriteSize = CGSize(width: 251, height: 77)
    
    // Immagini
    private let towerFloorAtlas = SKTextureAtlas(named: "Block")

    //Enumeratori
    enum ENModelliStanza: Int {
        case InCostruzione = 0,
        CodeDesign,
        GraphicsDesign,
        AudioDesign,
        CoreDesign
    }

    // Variabili
    private var nomeTexture: String = ""
    private var modello: ENModelliStanza = ENModelliStanza.InCostruzione
    private var titoloStanza: String = ""
    
    public var tipoBlocco: Character = "\u{00a0}"
    public var numeroDipendenti: Int = 0
    public var livelloBlocco: Int = 0
    public var contributoBlocco: Int = 0
    public var percentualeContributo: Int = 0
    public var isAnimated: Bool = false
    
    // Eventi
    var actionOnCompleteProgressBar: Selector?
    var actionOnAddNewEnployer: Selector?
    weak var targetOnCompleteProgressBar: AnyObject?
    weak var targetOnAddNewEnployer: AnyObject?
    
    // Proprietà
    var isEnabled: Bool = true {
        // Quando la stanza non è attiva, viene visualizzata una stanza scura senza animazioni
        // Quando la stanza è attiva, viene visualizzata una stanza illuminata con le animazioni
        didSet {
            setModello(tipo: modello, isEnabled: isEnabled)
        }
    }
    var isSelected: Bool = false {
        // Quando è selezionata appare la pop-up riepilogativa
        didSet {
            if(isEnabled) {
                setModello(tipo: modello, isEnabled: isEnabled)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        // Carico la texture usata
        super.init(texture: self.towerFloorAtlas.textureNamed("InCostruzione"),
                   color: UIColor.clear,
                   size: spriteSize)
        
        // Inizializza il modello base
        setModello(tipo: ENModelliStanza.InCostruzione, isEnabled: isEnabled)
        

        self.anchorPoint = CGPoint.zero

    }

    init(modello: ENModelliStanza) {
        
        // Carico la texture usata
        super.init(texture: self.towerFloorAtlas.textureNamed("InCostruzione"),
                   color: UIColor.clear,
                   size: spriteSize)
        setModello(tipo: modello, isEnabled: isEnabled)

        self.anchorPoint = CGPoint.zero
    }
    
    func setModello(tipo: ENModelliStanza, isEnabled: Bool) {

        // Elimino tutti i nodi inseriti
        self.removeAllChildren()
        self.modello = tipo

        // Imposto lo sfondo
        switch tipo {
        case ENModelliStanza.InCostruzione:
            self.texture = self.towerFloorAtlas.textureNamed("InCostruzione")
            self.titoloStanza = "Aggiungi nuova stanza"
            
        case ENModelliStanza.CodeDesign:
            self.texture = isEnabled ? self.towerFloorAtlas.textureNamed("CodeDesign") : self.towerFloorAtlas.textureNamed("CodeDesignDisabled")
            self.titoloStanza = "Codice Design"
            
        default:
            self.texture = self.towerFloorAtlas.textureNamed("InCostruzione")
            self.titoloStanza = "Aggiungi nuova stanza"
        }
        
        // Titolo stanza
        let titoloBlock = SKLabelNode(fontNamed: "Helvetica-Bold")
        titoloBlock.name = "TitoloBlock"
        titoloBlock.position = CGPoint(x: self.size.width / 2,
                                       y: self.size.height - 9)
        titoloBlock.fontColor = UIColor.black
        titoloBlock.fontSize = 8
        titoloBlock.zPosition = 1
        titoloBlock.text = self.titoloStanza
        self.addChild(titoloBlock)

        if(modello != ENModelliStanza.InCostruzione) {
            // Inserisce le icone dei dipendenti
            for index in 0...5 {
                let omino = SKSpriteNode(texture: self.towerFloorAtlas.textureNamed("OminoWhiteTitleBar"))
                omino.name = "Omino\(index + 1)"
                omino.anchorPoint = CGPoint.zero
                omino.position = CGPoint(x: 2 + (omino.size.width * CGFloat(index)),
                                         y: (self.size.height - omino.size.height - 1 ))
                omino.zPosition = 1
                omino.isHidden = true
                addChild(omino)
            }
            
            // Box ProgressBar
            let bkProgressBar = SKSpriteNode(texture: self.towerFloorAtlas.textureNamed("BoxProgressTitleBar"))
            bkProgressBar.name = "BkProgressBar"
            bkProgressBar.anchorPoint = CGPoint.zero
            bkProgressBar.position = CGPoint(x: (self.size.width - bkProgressBar.frame.size.width - 3),
                                             y: (self.size.height - bkProgressBar.frame.size.height - 2))
            bkProgressBar.zPosition = 1
            addChild(bkProgressBar)
            
            // Tratto ProgressBar
            for index in 0...11 {
                let trattoProgressBar = SKSpriteNode(texture: self.towerFloorAtlas.textureNamed("TrattoPercentualeProgressBar"))
                trattoProgressBar.name = "Tratto\(index + 1)"
                trattoProgressBar.anchorPoint = CGPoint.zero
                trattoProgressBar.position = CGPoint(x: (trattoProgressBar.size.width * CGFloat(index)),
                                                     y: 0)
                trattoProgressBar.zPosition = 1
                trattoProgressBar.isHidden = false
                bkProgressBar.addChild(trattoProgressBar)
            }
            
            // Label ProgressBar
            let indiceProgressBar2 = SKLabelNode(fontNamed: "Helvetica-Bold")
            indiceProgressBar2.name = "IndiceOmbra"
            indiceProgressBar2.position = CGPoint(x: (bkProgressBar.size.width / 2 ) + 0.5,
                                                  y: -0.5)
            indiceProgressBar2.fontColor = UIColor.white
            indiceProgressBar2.fontSize = 8
            indiceProgressBar2.zPosition = 2
            indiceProgressBar2.text = "0%"
            bkProgressBar.addChild(indiceProgressBar2)
            
            let indiceProgressBar = SKLabelNode(fontNamed: "Helvetica-Bold")
            indiceProgressBar.name = "Indice"
            indiceProgressBar.position = CGPoint(x: bkProgressBar.size.width / 2,
                                                 y: 0)
            indiceProgressBar.fontColor = UIColor.black
            indiceProgressBar.fontSize = 8
            indiceProgressBar.zPosition = 3
            indiceProgressBar.text = "0%"
            bkProgressBar.addChild(indiceProgressBar)
        }
    }

    func setNumeroDipendenti(numeroDipendenti: Int) {
        if(self.numeroDipendenti != numeroDipendenti) {
            // Faccio scattare l'evento per cambio numero dipendenti
            if (targetOnAddNewEnployer != nil && targetOnAddNewEnployer!.responds(to: actionOnAddNewEnployer!)) {
                UIApplication.shared.sendAction(actionOnAddNewEnployer!, to: targetOnAddNewEnployer, from: self, for: nil)
            }
            
            self.numeroDipendenti = numeroDipendenti
            for index in 1...6 {
                let omino = self.childNode(withName: "Omino\(index)") as! SKSpriteNode
                omino.isHidden = !(index <= numeroDipendenti)
            }
        }
    }

    func addPercentualeProgressBar(percentuale: Int) {
        self.percentualeContributo += percentuale
        if(self.percentualeContributo > 100)
        {
            // Faccio scattare l'evento per completamento ProgressBar
            if (targetOnCompleteProgressBar != nil && targetOnCompleteProgressBar!.responds(to: actionOnCompleteProgressBar!)) {
                UIApplication.shared.sendAction(actionOnCompleteProgressBar!, to: targetOnCompleteProgressBar, from: self, for: nil)
            }
            // Azzero il contatore
            self.percentualeContributo = 0
        }

        let bkProgressBar = self.childNode(withName: "BkProgressBar") as! SKSpriteNode
        for index in 1...12 {
            let tratto = bkProgressBar.childNode(withName: "Tratto\(index)") as! SKSpriteNode
            tratto.isHidden = !(index <= Int(self.percentualeContributo / 8))
        }
        let indice = bkProgressBar.childNode(withName: "Indice") as! SKLabelNode
        indice.text = "\(self.percentualeContributo)%"
        let indiceOmbra = bkProgressBar.childNode(withName: "IndiceOmbra") as! SKLabelNode
        indiceOmbra.text = "\(self.percentualeContributo)%"
    }
    
    func setAction(target: AnyObject, triggerEvent event:ENBlockActionType, action:Selector) {
        switch (event) {
        case .OnCompleteProgressBar:
            targetOnCompleteProgressBar = target
            actionOnCompleteProgressBar = action
        case .OnAddNewEnployer:
            targetOnAddNewEnployer = target
            actionOnAddNewEnployer = action
        }
    }
    
    func update(currentTime: TimeInterval){
        if(!isEnabled || !isAnimated) {
            return
        }

        if(self.modello != ENModelliStanza.InCostruzione) {
            addPercentualeProgressBar(percentuale: 1)
        }
    }
    
}
