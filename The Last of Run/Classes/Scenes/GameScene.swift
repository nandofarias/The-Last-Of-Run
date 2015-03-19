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
    var parallaxNode:CCParallaxNode = CCParallaxNode()
    let bgSpace1:CCSprite = CCSprite(imageNamed: "bgSpaceParallax.png")
    let bgSpace2:CCSprite = CCSprite(imageNamed: "bgSpaceParallax.png")
	
	// MARK: - Life Cycle
	override init() {
		super.init()

        
        self.createSceneObjects()

		
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
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
        if (self.parallaxNode.convertToWorldSpace(self.bgSpace1.position).y < -self.bgSpace1.contentSize.height) {
            self.parallaxNode.position = CGPointMake(0.0, 0.0)
        }
	}

	// MARK: - Private Methods

	// MARK: - Public Methods
	
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
    
    func createSceneObjects(){
        // Configura o parallax infinito
        self.bgSpace1.position = CGPointMake(0.0, 0.0)
        self.bgSpace1.anchorPoint = CGPointMake(0.0, 0.0)
        self.bgSpace2.position = CGPointMake(0.0, 0.0)
        self.bgSpace2.anchorPoint = CGPointMake(0.0, 0.0)
        self.parallaxNode.position = CGPointMake(0.0, 0.0)
        self.parallaxNode.addChild(self.bgSpace1, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, 0.0))
        self.parallaxNode.addChild(self.bgSpace2, z: 1, parallaxRatio:CGPointMake(0.0, 0.5), positionOffset:CGPointMake(0.0, self.bgSpace1.contentSize.height))
        self.addChild(self.parallaxNode, z: ObjectsLayers.Background.rawValue)
        
        // Back button
        let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 38.0)
        backButton.position = CGPointMake(screenSize.width, screenSize.height)
        backButton.anchorPoint = CGPointMake(1.0, 1.0)
        backButton.zoomWhenHighlighted = false
        backButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)}
        self.addChild(backButton)
    }
}
