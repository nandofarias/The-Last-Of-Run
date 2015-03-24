//
//  GameScene.swift
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

// MARK: - Class Definition
class GameScene: CCScene, CCPhysicsCollisionDelegate {
	// MARK: - Public Objects
	
	// MARK: - Private Objects
    
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private var canTap:Bool = true
    private var score:Int = 0
    private var scoreLabel:CCLabelTTF = CCLabelTTF(string:"Kills: 0", fontName:"Verdana", fontSize:32.0)
    var shieldLabel:CCLabelTTF = CCLabelTTF(string: "Escudo: 100.0%", fontName: "Verdana-Bold", fontSize: 18.0)
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var player:PlayerCar = PlayerCar(imageNamed:"Carrinho1.png")
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
        
        // Registra a criacao de zumbis
        DelayHelper.sharedInstance.callFunc("generateZombie", onTarget: self, withDelay: 0.1)

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
    func createSceneObjects(){
        
        // Define o mundo
        //debugdraw para ver area de colisao
        //self.physicsWorld.debugDraw = true
        self.physicsWorld.collisionDelegate = self
        self.physicsWorld.gravity = CGPointZero
        self.addChild(self.physicsWorld, z:ObjectsLayers.Background.rawValue)
        
        // Escudo do player
        self.shieldLabel.fontColor = CCColor.whiteColor()
        self.shieldLabel.position = CGPointMake(0.0, screenSize.height)
        self.shieldLabel.anchorPoint = CGPointMake(0.0, 1.0)
        self.addChild(self.shieldLabel, z: ObjectsLayers.HUD.rawValue)
        
        
        // Configura o parallax infinito
        self.bgroad1.position = CGPointMake(0.0, 0.0)
        self.bgroad1.anchorPoint = CGPointMake(0.0, 0.0)
        self.bgroad2.position = CGPointMake(0.0, 0.0)
        self.bgroad2.anchorPoint = CGPointMake(0.0, 0.0)
        self.parallaxNode.position = CGPointMake(0.0, 0.0)
        self.parallaxNode.addChild(self.bgroad1, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, 0.0))
        self.parallaxNode.addChild(self.bgroad2, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, self.bgroad1.contentSize.height))
        self.physicsWorld.addChild(self.parallaxNode, z: ObjectsLayers.Background.rawValue)
        
        // Back button
        let backButton:CCButton = CCButton(title: "", spriteFrame: CCSpriteFrame.frameWithImageNamed("back.png") as CCSpriteFrame)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in
            StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)
        }
        self.addChild(backButton, z:ObjectsLayers.HUD.rawValue)
        
        // Configura o heroi na tela
        self.player.position = CGPointMake(screenSize.width/2.0, 60.0)
        self.physicsWorld.addChild(self.player, z:ObjectsLayers.Player.rawValue)
    }
    
    func generateZombie() {
        if (self.canPlay) {
            // Quantidade de inseto gerado por vez...
            //let bugAmout:Int = Int(arc4random_uniform(5) + 1)
            
            for (var i = 0; i < 1; i++) {
                let positionX:CGFloat = CGFloat(arc4random_uniform(824) + 100)
                var zombie:Zumbi = Zumbi(event: "updateScore", target: self)
                zombie.position = CGPointMake(positionX, self.screenSize.height + (CGFloat(arc4random_uniform(100) + 50)))
                zombie.name = "z"
                self.physicsWorld.addChild(zombie, z:ObjectsLayers.Foes.rawValue)
                zombie.moveMe()
            }
            
            // Apos geracao, registra nova geracao apos um tempo
            DelayHelper.sharedInstance.callFunc("generateZombie", onTarget: self, withDelay: 0.8)
        }
    }
    
    func createParticleAtPosition(aPosition:CGPoint) {
        // Config File
        var particleFile:CCParticleSystem = CCParticleSystem(file: "ShipBlow.plist")
        particleFile.position = aPosition
        particleFile.autoRemoveOnFinish = true
        self.addChild(particleFile, z:ObjectsLayers.Player.rawValue)
    }
    
    func doGameOver() {
        self.canPlay = false
        self.isTouching = false
        self.createParticleAtPosition(self.player.position)
        self.player.removeFromParentAndCleanup(true)
        
        // Exibe o texto game over
        let gameover:CCSprite = CCSprite(imageNamed: "gameover.png")
        gameover.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        gameover.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(gameover, z:ObjectsLayers.HUD.rawValue)
    }
    
	// MARK: - Public Methods
    func updateScore() {
        self.score+=1
        self.scoreLabel.string = "Kills: \(self.score)"
    }
    

    
	// MARK: - Delegates/Datasources
    // MARK: - Touchs Delegates
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay) {
            self.isTouching = true
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            
            let centro:CGFloat = self.screenSize.width / 2.0
            
            if ( centro > locationInView.x) {
                self.player.position = CGPointMake(self.player.position.x - 20.0, self.player.position.y)
                self.player.changeToJumping()
            } else {
                self.player.position = CGPointMake(self.player.position.x + 20.0, self.player.position.y)
            }
            

        }
    }
    
    // MARK: - CCPhysicsCollisionDelegate
    // ======= Validacao para colisoes entre o carro e os zumbis
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, PlayerCar player:PlayerCar!, Zumbi aZombie:Zumbi!) -> Bool {
        player.shield -= 10
        if (player.shield <= 0) {
            player.shield = 0
            self.doGameOver()
        }
        
        // Explode e remove a nave
        //SoundPlayHelper.sharedInstance.playSoundWithControl(GameMusicAndSoundFx.SoundFXButtonShipBoom)
        self.createParticleAtPosition(aZombie.position)
        aZombie.removeFromParentAndCleanup(true)
        
        // Configura o display da vida do player
        self.shieldLabel.string = "Escudo: \(player.shield)%"
        
        return true
    }

    
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
    

}
