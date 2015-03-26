//
//  PlayerCar.swift
//  The Last of Run
//
//  Created by Rodrigo Ota on 22/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation
// MARK: - Class Definition
class PlayerCar : CCSprite {
    
    // MARK: - Public Objects
    var carStatus:CGFloat = 100.0
    var gasoline:CGFloat = 100.0
    var isLeft:Bool = false
    var isRight:Bool = false
    var raia:CGFloat = 160.0
    
    var turnLeft:CCActionAnimate?
    var turnRight:CCActionAnimate?
    
    // MARK: - Private Objects
    
    // MARK: - Life Cycle
    override init() {
        super.init()
    }
    
    override init(CGImage image: CGImage!, key: String!) {
        super.init(CGImage: image, key: key)
    }
    
    override init(spriteFrame: CCSpriteFrame!) {
        super.init(spriteFrame: spriteFrame)
    }
    
    override init(texture: CCTexture!) {
        super.init(texture: texture)
    }
    
    override init(texture: CCTexture!, rect: CGRect) {
        super.init(texture: texture, rect: rect)
    }
    
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) {
        super.init(texture: texture, rect: rect, rotated: rotated)
    }
    
    override init(imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
        
        self.turnLeft = self.createActionLeft()
        self.turnRight = self.createActionRight()
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "PlayerCar"
        self.physicsBody.collisionCategories = ["PlayerCar"]
        self.physicsBody.collisionMask = ["Zumbi", "Gasolina", "Cerca"]
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    func createActionLeft() -> CCActionAnimate {
        let aName:String = "playercar"
        let qtdFrames:Int = 5
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 1; i <= qtdFrames; i++) {
            let name:String = "\(aName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        /*for (var i = 2; i <= 1; i--) {
            let name:String = "\(aName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }*/
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        
        
        
        return animationAction
    }
    func createActionRight() -> CCActionAnimate {
        let aName:String = "playercar"
        let qtdFrames:Int = 10
        // Carrega os frames da animacao dentro do arquivo passado dada a quantidade de frames
        var animFrames:Array<CCSpriteFrame> = Array()
        for (var i = 5; i <= qtdFrames; i++) {
            let name:String = "\(aName)\(i).png"
            animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }
        /*for (var i = 2; i <= 1; i--) {
        let name:String = "\(aName)\(i).png"
        animFrames.append(CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name))
        }*/
        // Cria a animacao dos frames montados
        let animation:CCAnimation = CCAnimation(spriteFrames: animFrames, delay: 0.1)
        // Cria a acao com a animacao dos frames
        let animationAction:CCActionAnimate = CCActionAnimate(animation: animation)
        
        return animationAction
    }
    
    
    // MARK: - Public Methods
    func changeToRight(raia: CGFloat) {
        // Previne chamadas repetidas
        if (!self.isLeft) {
            // Cancela a animacao existente no alien
            self.stopAllActions()
            self.isLeft = true
            // Redefine a imagem - teste
            //self.spriteFrame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName("Carrinho3.png")
            
            // Redefine a acao - CCActionSpawn para rodar acoes simultaneas
            let arrActions:[CCAction] =
            [self.createActionLeft() as CCAction, CCActionMoveTo.actionWithDuration(0.5, position:CGPointMake(raia, self.position.y)) as CCAction
                , CCActionCallBlock.actionWithBlock( {_ in
                    println("Foi para esquerda")
                    self.isLeft = false
                }) as CCAction]
            let acoes:CCAction = CCActionSpawn.actionWithArray(arrActions) as CCAction
            
            self.runAction(acoes)

            
            

        }
    }
    
    func changeToLeft(raia: CGFloat) {
        // Previne chamadas repetidas
        if (!self.isRight) {
            // Cancela a animacao existente no alien
            self.stopAllActions()
            self.isRight = true
            // Redefine a acao - (animacao completa)
        
            let arrActions:[CCAction] =
            [self.createActionRight() as CCAction, CCActionMoveTo.actionWithDuration(0.5, position:CGPointMake(raia, self.position.y)) as CCAction
                , CCActionCallBlock.actionWithBlock( {_ in
                    println("Foi para Direita")
                    self.isRight = false
                }) as CCAction]
            let acoes:CCAction = CCActionSpawn.actionWithArray(arrActions) as CCAction
        
            self.runAction(acoes)
            
        }
    }
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
}
