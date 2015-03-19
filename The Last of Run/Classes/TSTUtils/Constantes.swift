//
//  Constantes.swift
//  The Last of Run
//
//  Created by NandoFarias on 18/03/15.
//  Copyright (c) 2015 Flameworks. All rights reserved.
//

import Foundation

let screenSize:CGSize = CCDirector.sharedDirector().viewSize()

// Layers dos objetos
enum ObjectsLayers:Int {
    case HUD = 5
    case Shot = 4
    case Player = 3
    case Foes = 2
    case Background = 1
}