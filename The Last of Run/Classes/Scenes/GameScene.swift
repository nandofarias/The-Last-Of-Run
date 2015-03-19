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
	
	// MARK: - Life Cycle
	override init() {
		super.init()

		// Label loading
		let label:CCLabelTTF = CCLabelTTF(string: "Game Scene", fontName: "Chalkduster", fontSize: 36.0)
		label.color = CCColor.redColor()
		label.position = CGPointMake(self.screenSize.width/2, self.screenSize.height/2)
		label.anchorPoint = CGPointMake(0.5, 0.5)
		self.addChild(label)

		// Back button
		let backButton:CCButton = CCButton(title: "[ Back ]", fontName: "Verdana-Bold", fontSize: 38.0)
		backButton.position = CGPointMake(self.screenSize.width, self.screenSize.height)
		backButton.anchorPoint = CGPointMake(1.0, 1.0)
		backButton.zoomWhenHighlighted = false
		backButton.block = {_ in StateMachine.sharedInstance.changeScene(StateMachineScenes.HomeScene, isFade:true)}
		self.addChild(backButton)
	}

	override func onEnter() {
		// Chamado apos o init quando entra no director
		super.onEnter()
	}

	// Tick baseado no FPS
	override func update(delta: CCTime) {
		//...
	}

	// MARK: - Private Methods

	// MARK: - Public Methods
	
	// MARK: - Delegates/Datasources
	
	// MARK: - Death Cycle
	override func onExit() {
		// Chamado quando sai do director
		super.onExit()
	}
}
