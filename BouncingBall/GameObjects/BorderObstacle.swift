//
//  BorderObstacle.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

/*class BorderObstacle: SKShapeNode {

    convenience init(rectOf size: CGSize) {
        self.init()

        self.name = "borderObstacle"
        self.fillColor = SKColor.white

        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = PhysicsCategories.borderObstacle
        //self.physicsBody?.contactTestBitMask =
        self.physicsBody?.collisionBitMask = PhysicsCategories.ball | PhysicsCategories.bouncingFist
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
}*/

class BorderObstacle: SKSpriteNode {

    var state: String

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        self.state = "down"

        super.init(texture: texture, color: color, size: size)

        self.name = "borderObstacle"

        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = PhysicsCategories.borderObstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategories.ball
        self.physicsBody?.collisionBitMask = PhysicsCategories.ball
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
