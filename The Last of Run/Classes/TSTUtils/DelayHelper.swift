//
//  DelayHelper.m
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

class DelayHelper {
	// MARK Public Declarations
	
	// MARK Private Declarations

	// MARK: - Singleton
	class var sharedInstance:DelayHelper {
	struct Static {
			static var instance: DelayHelper?
			static var token: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = DelayHelper()
		}

		return Static.instance!
	}

	// MARK: Private Methods

	// MARK: Public Methods
	func callFunc(aFunc:Selector, onTarget:AnyObject, withDelay:CCTime) {
		// Monta o metodo com o delay informado
		let delayAction:CCActionSequence = CCActionSequence(
											one:(CCActionDelay.actionWithDuration(withDelay) as CCActionFiniteTime),
											two:(CCActionCallFunc.actionWithTarget(onTarget, selector:aFunc) as CCActionFiniteTime))

		// Invoca pelo director
		CCDirector.sharedDirector().actionManager.addAction(delayAction, target:self, paused:false)
	}

	func callBlock(aBlock:(() -> Void), withDelay:CCTime) {
		// Monta o bloco com o delay informado
		let delayAction:CCActionSequence = CCActionSequence(
			one:(CCActionDelay.actionWithDuration(withDelay) as CCActionFiniteTime),
			two:(CCActionCallBlock.actionWithBlock(aBlock) as CCActionFiniteTime))

		// Invoca pelo director
		CCDirector.sharedDirector().actionManager.addAction(delayAction, target:self, paused:false)
	}
}
