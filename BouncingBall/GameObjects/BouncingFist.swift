//
//  BouncingFist.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

class BouncingFist: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //super.init(texture: nil, color: color, size: size)
        self.colorBlendFactor = 1
        self.name = "bouncingFist"

        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        //self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategories.bouncingFist
        //self.physicsBody?.contactTestBitMask = 
        self.physicsBody?.collisionBitMask = PhysicsCategories.ball | PhysicsCategories.borderObstacle
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
