//
//  Player.swift
//
//  Part 1 of the SceneKit Tutorial Series 'From Zero to Hero' at:
//  https://rogerboesch.github.io/
//
//  Created by Roger Boesch on 12/07/16.
//  Copyright © 2016 Roger Boesch. All rights reserved.
//

import SceneKit

// -----------------------------------------------------------------------------

class Player : SCNNode {
    private let lookAtForwardPosition = SCNVector3Make(0.0, 0.0, 1.0)
    private let cameraFowardPosition = SCNVector3(x: 0.8, y: 50, z: -0.5)

    private var _lookAtNode: SCNNode?
    private var _cameraNode: SCNNode?
    private var _playerNode: SCNNode?
    
    // -------------------------------------------------------------------------
    // MARK: - Initialisation
    
    override init() {
        super.init()
        
        // Create player node
        let cubeGeometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.0)
        _playerNode = SCNNode(geometry: cubeGeometry)
        _playerNode?.isHidden = false // true
        addChildNode(_playerNode!)

        let colorMaterial = SCNMaterial()
        cubeGeometry.materials = [colorMaterial]
        
        // Look at Node
        _lookAtNode = SCNNode()
        _lookAtNode!.position = lookAtForwardPosition
        addChildNode(_lookAtNode!)

        // Debug sphere
        let g = SCNSphere(radius: 1)
        g.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode(geometry: g)
        node.position = SCNVector3(x: 0, y: -2, z: 0)
        addChildNode(node)
        
        // Camera Node
        _cameraNode = SCNNode()
        _cameraNode!.camera = SCNCamera()
        _cameraNode!.position = cameraFowardPosition
        _cameraNode!.camera!.zNear = 0.1
        _cameraNode!.camera!.zFar = 200
        self.addChildNode(_cameraNode!)

        // Link them
        let constraint1 = SCNLookAtConstraint(target: _lookAtNode)
        constraint1.isGimbalLockEnabled = true
        _cameraNode!.constraints = [constraint1]
        
        // Create a spotlight at the player
        let spotLight = SCNLight()
        spotLight.type = SCNLight.LightType.spot
        spotLight.spotInnerAngle = 40.0
        spotLight.spotOuterAngle = 80.0
        spotLight.castsShadow = true
        spotLight.color = UIColor.white
        let spotLightNode = SCNNode()
        spotLightNode.light = spotLight
        spotLightNode.position = SCNVector3(x: 1.0, y: 5.0, z: -2.0)
        self.addChildNode(spotLightNode)

        // Link it
        let constraint2 = SCNLookAtConstraint(target: self)
        constraint2.isGimbalLockEnabled = true
        spotLightNode.constraints = [constraint2]

        // Create additional omni light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.light!.color = UIColor.darkGray
        lightNode.position = SCNVector3(x: 0, y: 10.00, z: -2)
        self.addChildNode(lightNode)
    }
    
    // -------------------------------------------------------------------------
    
    required init(coder: NSCoder) {
        fatalError("Not yet implemented")
    }
    
    // -------------------------------------------------------------------------    

}
