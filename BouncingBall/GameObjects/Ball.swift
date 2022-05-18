//
//  Ball.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        self.colorBlendFactor = 1
        self.name = "ball"

        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.categoryBitMask = PhysicsCategories.ball
        self.physicsBody?.contactTestBitMask = PhysicsCategories.bouncingFist | PhysicsCategories.sceneBorder | PhysicsCategories.borderObstacle
        self.physicsBody?.collisionBitMask = PhysicsCategories.bouncingFist | PhysicsCategories.borderObstacle
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1
        self.physicsBody?.friction = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
