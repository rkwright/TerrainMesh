//
//  GameLevel.swift
//
//  Part 1 of the SceneKit Tutorial Series 'From Zero to Hero' at:
//  https://rogerboesch.github.io/
//
//  Created by Roger Boesch on 12/07/16.
//  Copyright © 2016 Roger Boesch. All rights reserved.
//

import UIKit
import SceneKit

// -----------------------------------------------------------------------------

class GameLevel: SCNScene, SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
    private let levelWidth = 320
    private let levelLength = 320
    
    private var _terrain: RBTerrain?
    private var _player: Player?

    // -------------------------------------------------------------------------
    // MARK: - Place objects

    private func addPlayer() {
        _player = Player()
        _player!.position = SCNVector3(160, 3, 0)
        self.rootNode.addChildNode(_player!)

        let moveAction = SCNAction.moveBy(x: 0, y: 0, z: 200, duration: 50)
        _player!.runAction(moveAction)
        
        dumpSCNNode(node: self.rootNode)
    }

    // -------------------------------------------------------------------------

    private func addTerrain() {
        // Create terrain
        _terrain = RBTerrain(width: levelWidth, length: levelLength, scale: 128)

        let generator = RBPerlinNoiseGenerator(seed: nil)
        _terrain?.formula = {(x: Int32, y: Int32) in
            return generator.valueFor(x: x, y: y)
        }

        _terrain!.create(withColor: UIColor.red)
        _terrain!.position = SCNVector3Make(0, 0, 0)
        self.rootNode.addChildNode(_terrain!)
    }

    // ---------------------------------------------------------------------------
    
    private func addSphere() {
        
        let g = SCNSphere(radius: 1)
        g.firstMaterial?.diffuse.contents = UIColor.red
        let node = SCNNode(geometry: g)
        node.position = SCNVector3(x: 0, y: 0, z: 0)
        self.rootNode.addChildNode(node)
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Initialisation
    
    func create() {
        addTerrain()
        addPlayer()
        //addSphere()
    }
    
    // -------------------------------------------------------------------------
    
    override init() {
        super.init()
    }
    
    // -------------------------------------------------------------------------
    
    required init(coder: NSCoder) {
        fatalError("Not yet implemented")
    }
    
    // -------------------------------------------------------------------------
        
    private func dumpSCNNode ( node: SCNNode ) {
        
        print("Node: ", node)
        if let nom = node.name {
            print("Name: " + nom)
        }
        else {
            print("Unnamed")
        }
        
        let count = node.childNodes.count
        for i in 0..<count {
            print("i: " , i )
            dumpSCNNode(node: node.childNodes[i])
        }
    }
    
}
