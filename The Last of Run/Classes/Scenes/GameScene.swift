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
    private let raia1:CGFloat = 35.0
    private let raia2:CGFloat = 95.0
    private let raia3:CGFloat = 160.0
    private let raia4:CGFloat = 230.0
    private let raia5:CGFloat = 285.0
    
    private let screenSize:CGSize = CCDirector.sharedDirector().viewSize()
    private var canTap:Bool = true
    private var score:Int = 0
    private var velLevel:CGFloat = -300.0
    private var velSprites:CGFloat = 4.5
    private var gasLabel:CCLabelTTF = CCLabelTTF(string:"Gasolina: 100%", fontName:"Verdana-Bold", fontSize:18.0)
    
    var carStateLabel:CCLabelTTF = CCLabelTTF(string: "Carro: 100.0%", fontName: "Verdana-Bold", fontSize: 18.0)
    var scoreLabel:CCLabelTTF = CCLabelTTF(string: "Tempo: 0s", fontName: "Verdana-Bold", fontSize: 18.0)
    var physicsWorld:CCPhysicsNode = CCPhysicsNode()
    var player:PlayerCar = PlayerCar(imageNamed:"playercar1.png")
    var canPlay:Bool = true
    var isTouching:Bool = true
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
        
        // Estado do carro do player
        self.carStateLabel.fontColor = CCColor.whiteColor()
        self.carStateLabel.position = CGPointMake(0.0, screenSize.height)
        self.carStateLabel.anchorPoint = CGPointMake(0.0, 1.0)
        self.addChild(self.carStateLabel, z: ObjectsLayers.HUD.rawValue)
        
        // Gasolina
        self.gasLabel.fontColor = CCColor.whiteColor()
        self.gasLabel.position = CGPointMake(0.0, screenSize.height - 20.0)
        self.gasLabel.anchorPoint = CGPointMake(0.0, 1.0)
        self.addChild(self.gasLabel, z: ObjectsLayers.HUD.rawValue)
        
        // Score
        self.scoreLabel.fontColor = CCColor.redColor()
        self.scoreLabel.position = CGPointMake(0.0, screenSize.height - 40)
        self.scoreLabel.anchorPoint = CGPointMake(0.0, 1.0)
        self.addChild(self.scoreLabel, z: ObjectsLayers.HUD.rawValue)
        
        // Registra a criacao de zumbis
        DelayHelper.sharedInstance.callFunc("generateZombie", onTarget: self, withDelay: 0.1)
        
        // Registra o indicador da gasolina
        DelayHelper.sharedInstance.callFunc("outOfGasTick", onTarget: self, withDelay: 1.0)
        
        // Registra o indicador de score
        DelayHelper.sharedInstance.callFunc("updateScore", onTarget: self, withDelay: 1.0)
        
        // Registra a criacao da gasolina
        DelayHelper.sharedInstance.callFunc("generateGas", onTarget: self, withDelay: 20.0)

	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
        
        // ==================== CONTROLE DO PARALLAX
        // Parallax infinito com apenas uma imagem
        
        // controle para aumentar a velocidade do parallax
        var backgroundScrollVel:CGPoint
        if (velLevel < -1000) {
            backgroundScrollVel = CGPointMake(0, -1000)
        } else {
            backgroundScrollVel = CGPointMake(0, velLevel--)
        }
        
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

        
        // Configura o parallax infinito
        self.bgroad1.position = CGPointMake(0.0, 0.0)
        self.bgroad1.anchorPoint = CGPointMake(0.0, 0.0)
        self.bgroad2.position = CGPointMake(0.0, 0.0)
        self.bgroad2.anchorPoint = CGPointMake(0.0, 0.0)
        self.parallaxNode.position = CGPointMake(0.0, 0.0)
        self.parallaxNode.addChild(self.bgroad1, z: 1, parallaxRatio:CGPointMake(0.0, 0.7), positionOffset:CGPointMake(0.0, 0.0))
        self.parallaxNode.addChild(self.bgroad2, z: 1, parallaxRatio:CGPointMake(0.0, 0.7), positionOffset:CGPointMake(0.0, self.bgroad1.contentSize.height))
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
        self.player.position = CGPointMake(raia3, 80.0)
        self.physicsWorld.addChild(self.player, z:ObjectsLayers.Player.rawValue)
    }
    
    
    func outOfGasTick() {
        if (self.canPlay) {
            if(self.player.raia == self.raia1 || self.player.raia == self.raia5){
                self.player.gasoline -= 10.0
            } else {
                self.player.gasoline -= 0.5
            }
            if (self.player.gasoline < 0) {
                self.gasLabel.string = "Gasolina: 0.0%"
                self.doGameOver()
            } else {
                self.gasLabel.string = "Gasolina: \(player.gasoline)%"
                // Chama de 1 em 1 seg
                DelayHelper.sharedInstance.callFunc("outOfGasTick", onTarget: self, withDelay: 1.0)
            }
        }
    }
    
    func updateScore() {
        if (self.canPlay) {
            
            switch (self.score) {
            case 20:
                self.velSprites = 4
                break;
            case 30:
                self.velSprites = 3
                break;
            case 40:
                self.velSprites = 2
                break;
            case 50:
                self.velSprites = 1
                break;
            case 60:
                self.velSprites = 0.5
                break;
            default:
                println("nada...")
                break;
            }
            
            self.score++
            self.scoreLabel.string = "Tempo: \(self.score)s"
            // Chama de 1 em 1 seg
            DelayHelper.sharedInstance.callFunc("updateScore", onTarget: self, withDelay: 1.0)
        }
    }

    
    func generateZombie() {
        if (self.canPlay) {
            // Quantidade de inseto gerado por vez...
            //let bugAmout:Int = Int(arc4random_uniform(5) + 1)
            
            for (var i = 0; i < 1; i++) {
                let auxPosition:CGFloat = CGFloat(arc4random_uniform(3)+2)
                var positionX:CGFloat = self.raia3
                switch auxPosition {
                case 2:
                    positionX = self.raia2
                    break;
                case 3:
                    positionX = self.raia3
                    break;
                case 4:
                    positionX = self.raia4
                    break;
                default:
                    println("nada...")
                    break;
                }
                var zombie:Zumbi = Zumbi(event: "updateScore", target: self)
                zombie.position = CGPointMake(positionX, self.screenSize.height + (CGFloat(arc4random_uniform(100) + 50)))
                zombie.name = "z"
                self.physicsWorld.addChild(zombie, z:ObjectsLayers.Foes.rawValue)
                zombie.moveMe(self.velSprites)
            }
            
            // Apos geracao, registra nova geracao apos um tempo
            DelayHelper.sharedInstance.callFunc("generateZombie", onTarget: self, withDelay: 1.0)
        }
    }
    
    func generateGas() {
        let auxPosition:CGFloat = CGFloat(arc4random_uniform(3)+2)
        var positionX:CGFloat = self.raia3
        switch auxPosition {
        case 2:
            positionX = self.raia2
            break;
        case 3:
            positionX = self.raia3
            break;
        case 4:
            positionX = self.raia4
            break;
        default:
            println("nada...")
            break;
        }
        var gas:Gasolina = Gasolina(imageNamed: "gas.png")
        gas.position = CGPointMake(positionX, self.screenSize.height + 50)
        gas.name = "gas"
        self.physicsWorld.addChild(gas, z:ObjectsLayers.Foes.rawValue)
        gas.moveMe(self.velSprites)
        
        // Apos geracao, registra nova geracao apos um tempo
        DelayHelper.sharedInstance.callFunc("generateGas", onTarget: self, withDelay: 20.0)
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
        
        // Registra o novo best score caso haja
        var scores: [Int] = NSUserDefaults.standardUserDefaults().objectForKey("scores") as [Int]
        
        scores.insert(self.score, atIndex: scores.count)
        
        scores.sort({ $0 > $1 })
        
        scores.removeLast()
        
        NSUserDefaults.standardUserDefaults().setObject(scores  , forKey: "scores")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        println(scores)
        
        // Percorre e cancela toda movimentacao dos insetos
        for node:AnyObject in self.children as Array<AnyObject> {
            if (node.isKindOfClass(Zumbi)) {
                let zumbi:Zumbi = node as Zumbi
                zumbi.stopAllSpriteActions()
            }
        }
        
        // Exibe o texto game over
        let gameover:CCSprite = CCSprite(imageNamed: "gameover.png")
        gameover.position = CGPointMake(screenSize.width/2, screenSize.height/2)
        gameover.anchorPoint = CGPointMake(0.5, 0.5)
        self.addChild(gameover, z:ObjectsLayers.HUD.rawValue)
    }
    
	// MARK: - Delegates/Datasources
    // MARK: - Touchs Delegates
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        if (self.canPlay) {
            let locationInView:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            
            println(locationInView)
            
            let centro:CGFloat = self.screenSize.width / 2.0
            
            if ( centro > locationInView.x) {
                //self.player.position = CGPointMake(self.player.position.x - 40.0, self.player.position.y)

                switch self.player.raia {
                    
                case self.raia1:
                    //...
                    break;
                case self.raia2:
                    self.player.setNewRaia(self.raia1)
                    break;
                case self.raia3:
                    self.player.setNewRaia(self.raia2)
                    break;
                case self.raia4:
                    self.player.setNewRaia(self.raia3)
                    break;
                case self.raia5:
                    self.player.setNewRaia(self.raia4)
                    break;
                default:
                    println("nada...")
                    break;
                }
                
                self.player.changeToRight(self.player.raia)
                
            } else {
                
                switch self.player.raia {
                case self.raia5:
                    
                    break;
                case self.raia4:
                    self.player.setNewRaia(self.raia5)
                    break;
                case self.raia3:
                    self.player.setNewRaia(self.raia4)
                    break;
                case self.raia2:
                    self.player.setNewRaia(self.raia3)
                    break;
                case self.raia1:
                    self.player.setNewRaia(self.raia2)
                    break;
                default:
                    println("nada...")
                    break;
                }
                self.player.changeToLeft(self.player.raia)
            }
            

        }
    }
    
    // MARK: - CCPhysicsCollisionDelegate
    // ======= Validacao para colisoes entre o carro e os zumbis
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, PlayerCar player:PlayerCar!, Zumbi aZombie:Zumbi!) -> Bool {
        player.carStatus -= 10
        if (player.carStatus <= 0) {
            player.carStatus = 0
            self.doGameOver()
        }
        
        // Atropela e remove o zumbi
        aZombie.runOver()
        
        // Configura o display da vida do player
        self.carStateLabel.string = "Carro: \(player.carStatus)%"
        
        return true
    }

    // ======= Validacao para colisoes entre o carro e a gasolina
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, PlayerCar player:PlayerCar!, Gasolina aGas:Gasolina!) -> Bool {
        
        //Pode aumentar a gasolina de 10 a 30
        player.gasoline += CGFloat(arc4random_uniform(20) + 10)
        
        if (player.gasoline > 100.0){
            player.gasoline = 100.0
        }
        
        //Colocar som do PowerUp
        
        // Remove a gasolina
        aGas.removeFromParentAndCleanup(true)
        
        // Configura o display da vida do player
        self.gasLabel.string = "Gasolina: \(player.gasoline)%"
        
        return true
    }
    
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
        CCTextureCache.sharedTextureCache().removeAllTextures()
	}
    

}
