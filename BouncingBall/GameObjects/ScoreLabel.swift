//
//  ScoreLabel.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

class ScoreLabel: SKLabelNode {

    override init(fontNamed fontName: String?) {
        super.init()

        self.text = "0"
        self.fontSize = 100.0
        self.fontColor = .white
        self.zPosition = -1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with score: Int) {
        self.text = "\(score)"
    }
}
