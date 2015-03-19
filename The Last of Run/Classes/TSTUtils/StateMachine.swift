//
//  StateMachine.m
//  CocosSwift
//
//  Created by Thales Toniolo on 10/09/14.
//  Copyright (c) 2014 Flameworks. All rights reserved.
//
import Foundation

enum StateMachineScenes {
	case LoadScene
	case HomeScene
	case GameScene
};

class StateMachine {
	// MARK Public Declarations

	// MARK Private Declarations

	// MARK: - Singleton
	class var sharedInstance:StateMachine {
		struct Static {
			static var instance: StateMachine?
			static var token: dispatch_once_t = 0
		}

		dispatch_once(&Static.token) {
			Static.instance = StateMachine()
		}

		return Static.instance!
	}

	// MARK: Private Methods
	private func retrieveScene(scene:StateMachineScenes) -> CCScene {
		switch (scene) {
		case StateMachineScenes.LoadScene:
			return LoadingScene()
		case StateMachineScenes.HomeScene:
			return HomeScene()
		case StateMachineScenes.GameScene:
			return GameScene()
		default:
			return CCScene()
		}
	}

	private func checkAndInitializeScene(scene:StateMachineScenes) -> CCScene {
		// Interrope todas as acoes do director
		CCDirector.sharedDirector().actionManager.removeAllActions()

		// Recupera a cena atual
		let currentScene:CCScene = CCDirector.sharedDirector().runningScene

		// Configura a proxima cena a ser executada
		let newScene:CCScene = retrieveScene(scene)

		// Controle para tocar a musica apenas na GameScene
		SoundPlayHelper.sharedInstance.stopAllSounds()
		if (currentScene.isKindOfClass(HomeScene) && newScene.isKindOfClass(GameScene)) {
			SoundPlayHelper.sharedInstance.playMusicWithControl(GameMusicAndSoundFx.MusicInGame, withLoop:true)
		}

		return newScene
	}

	// MARK: Public Methods
	func changeScene(scene:StateMachineScenes, isFade:Bool) {
		let newScene:CCScene = checkAndInitializeScene(scene)

		// Controle do director
		if (CCDirector.sharedDirector().runningScene == nil) {
			CCDirector.sharedDirector().runWithScene(newScene)
		} else {
			if (isFade) {
				CCDirector.sharedDirector().replaceScene(newScene, withTransition:CCTransition(fadeWithColor:CCColor.whiteColor(), duration: 0.7))
			} else {
				CCDirector.sharedDirector().replaceScene(newScene)
			}
		}
	}
}
