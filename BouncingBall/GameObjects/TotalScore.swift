//
//  TotalScore.swift
//  BouncingBall
//
//  Created by Ialgen on 03/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

class TotalScore: SKLabelNode {

    override init(fontNamed fontName: String?) {
        super.init()

        self.text = "Total score: \(UserDefaults.standard.integer(forKey: DefaultKeys.totalScore))"
        self.fontSize = 40.0
        self.fontColor = .white
        self.zPosition = -1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
