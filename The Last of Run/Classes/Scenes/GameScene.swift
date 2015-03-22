//
//  GameScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class GameScene: CCScene {
	// MARK: - Public Objects
	
	// MARK: - Private Objects
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private var canTap:Bool = true
    private var score:Int = 0
    private var scoreLabel:CCLabelTTF = CCLabelTTF(string:"Kills: 0", fontName:"Verdana", fontSize:32.0)
    
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var canPlay:Bool = true
    var isTouching:Bool = false
    var parallaxNode:CCParallaxNode = CCParallaxNode()
    let bgroad1:CCSprite = CCSprite(imageNamed: "road.png")
    let bgroad2:CCSprite = CCSprite(imageNamed: "road.png")
	
	// MARK: - Life Cycle
	override init() {
		super.init()

        self.userInteractionEnabled = true
        
        self.createSceneObjects()

		
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
        
        // Registra a criacao de barata
        DelayHelper.sharedInstance.callFunc("generateBug", onTarget: self, withDelay: 0.1)

	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
        
        // ==================== CONTROLE DO PARALLAX
        // Parallax infinito com apenas uma imagem
        var backgroundScrollVel:CGPoint = CGPointMake(0, -500)
        
        // Soma os pontos (posicao atual + (velocidade * delta))
        let pt1:CGFloat = backgroundScrollVel.y * CGFloat(delta)
        let multiDelta:CGPoint = CGPointMake(backgroundScrollVel.x, pt1)
        self.parallaxNode.position = CGPointMake(0.0, self.parallaxNode.position.y + multiDelta.y)
        
        // Valida qd a imagem xega ao fim para reposicionar as imagens
        if (self.parallaxNode.convertToWorldSpace(self.bgroad1.position).y < -self.bgroad1.contentSize.height) {
            self.parallaxNode.position = CGPointMake(0.0, 0.0)
        }
	}

	// MARK: - Private Methods
    func generateBug() {
        if (self.canPlay) {
            // Quantidade de inseto gerado por vez...
            //let bugAmout:Int = Int(arc4random_uniform(5) + 1)
            
            for (var i = 0; i < 1; i++) {
                let positionX:CGFloat = CGFloat(arc4random_uniform(824) + 100)
                var bug:Zumbi = Zumbi(event: "updateScore", target: self)
                bug.position = CGPointMake(positionX, self.screenSize.height + (CGFloat(arc4random_uniform(100) + 50)))
                bug.name = "z"
                self.addChild(bug, z: 2)
                bug.moveMe()
            }
            
            // Apos geracao, registra nova geracao apos um tempo
            DelayHelper.sharedInstance.callFunc("generateBug", onTarget: self, withDelay: 0.8)
        }
    }
    
	// MARK: - Public Methods
    func updateScore() {
        self.score+=1
        self.scoreLabel.string = "Kills: \(self.score)"
    }
    

    
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
    
    func createSceneObjects(){
        // Configura o parallax infinito
        self.bgroad1.position = CGPointMake(0.0, 0.0)
        self.bgroad1.anchorPoint = CGPointMake(0.0, 0.0)
        self.bgroad2.position = CGPointMake(0.0, 0.0)
        self.bgroad2.anchorPoint = CGPointMake(0.0, 0.0)
        self.parallaxNode.position = CGPointMake(0.0, 0.0)
        self.parallaxNode.addChild(self.bgroad1, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, 0.0))
        self.parallaxNode.addChild(self.bgroad2, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, self.bgroad1.contentSize.height))
        self.addChild(self.parallaxNode, z: ObjectsLayers.Background.rawValue)
        
        // Back button
        let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 18.0)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
    }
}
