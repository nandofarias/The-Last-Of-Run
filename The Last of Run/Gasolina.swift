//
//  Gasolina.swift
//  The Last of Run
//
//  Created by Rodrigo Ota on 25/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation
class Gasolina : CCSprite {
    
    // MARK: - Public Objects
    
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
        
        self.physicsBody = CCPhysicsBody(rect: CGRectMake(0, 0, self.contentSize.width/2, self.contentSize.height), cornerRadius: 0.0)
        self.physicsBody.type = CCPhysicsBodyType.Kinematic
        self.physicsBody.friction = 1.0
        self.physicsBody.elasticity = 0.1
        self.physicsBody.mass = 100.0
        self.physicsBody.density = 100.0
        self.physicsBody.collisionType = "Gasolina"
        self.physicsBody.collisionCategories = ["Gasolina"]
        self.physicsBody.collisionMask = ["PlayerCar"]
    }
    
    override func onEnter() {
        // Chamado apos o init quando entra no director
        super.onEnter()
    }
    
    // MARK: - Private Methods
    
    
    // MARK: - Public Methods
    internal func moveMe(vel : CGFloat) {
        let speed:CGFloat = vel
        self.runAction(CCActionSequence.actionOne(CCActionMoveTo.actionWithDuration(CCTime(speed), position: CGPointMake(self.position.x, self.height() * -2)) as CCActionFiniteTime,
            two: CCActionCallBlock.actionWithBlock({ _ in
                self.stopAllSpriteActions()
                self.removeFromParentAndCleanup(true)
            }) as CCActionFiniteTime)
            as CCAction)
    }
    
    internal func stopAllSpriteActions() {
        self.stopAllActions()
        self.stopAllActions()
    }
    
    internal func width() -> CGFloat {
        return self.boundingBox().size.width
    }
    
    internal func height() -> CGFloat {
        return self.boundingBox().size.height
    }
    
    // MARK: - Delegates/Datasources
    
    // MARK: - Death Cycle
    deinit {
        // Chamado no momento de desalocacao
    }
}
