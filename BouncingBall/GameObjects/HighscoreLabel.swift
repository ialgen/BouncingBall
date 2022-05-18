//
//  HighscoreLabel.swift
//  BouncingBall
//
//  Created by Ialgen on 03/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

class HighscoreLabel: SKLabelNode {

    override init(fontNamed fontName: String?) {
        super.init()

        self.text = "Highscore: \(UserDefaults.standard.integer(forKey: DefaultKeys.highscore))"
        self.fontSize = 40.0
        self.fontColor = .white
        self.zPosition = -1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with score: Int) {
        self.text = "Highscore: \(score)"
    }
}
