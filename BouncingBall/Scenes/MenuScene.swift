//
//  MenuScene.swift
//  BouncingBall
//
//  Created by Ialgen on 03/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//
// swiftlint:disable force_cast

import SpriteKit

class MenuScene: SKScene {

    var leaderboardButton: UIButton!
    var noAdsButton: UIButton!

    override func didMove(to view: SKView) {
        backgroundColor = .black
        addLabels()
        addButtons()
    }

    func addLabels() {
        let playLabel = SKLabelNode(text: "Tap to play!")
        playLabel.fontName = helveticaNeue
        playLabel.fontSize = 50.0
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animatePlayLabel(label: playLabel)

        let highscoreLabel = HighscoreLabel(fontNamed: helveticaNeue)
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - frame.height / 10)
        addChild(highscoreLabel)

        let totalScoreLabel = TotalScore(fontNamed: helveticaNeue)
        totalScoreLabel.position = CGPoint(x: frame.midX,
                                           y: highscoreLabel.position.y - totalScoreLabel.frame.size.height * 2)
        addChild(totalScoreLabel)
    }

    func animatePlayLabel(label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }

    func addButtons() {
        leaderboardButton = UIButton(frame: CGRect(x: frame.midX - 20,
                                                   y: frame.midY - frame.height / 4,
                                                   width: 40,
                                                   height: 40))
        leaderboardButton.setImage(UIImage(named: "Podium"), for: .normal)
        leaderboardButton.addTarget(self, action: #selector(leaderboard), for: .touchUpInside)
        self.view?.addSubview(leaderboardButton)

        /*noAdsButton = UIButton(frame: CGRect(x: frame.midX + 60,
                                             y: frame.midY - frame.height / 4,
                                             width: 40,
                                             height: 40))
        noAdsButton.setImage(UIImage(named: "StopAdsIcon"), for: .normal)
        self.view?.addSubview(noAdsButton)*/
    }

    @objc func leaderboard() {
        let viewController = self.view?.window?.rootViewController as! GameViewController
        /*viewController.saveHighscore(score: UserDefaults.standard.integer(forKey: DefaultKeys.highscore))
        viewController.saveTotalScore(score: UserDefaults.standard.integer(forKey: DefaultKeys.totalScore))*/
        viewController.showLeaderboard()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        removeButtons()
        view!.presentScene(gameScene)
    }

    func removeButtons() {
        leaderboardButton.removeFromSuperview()
        //noAdsButton.removeFromSuperview()
    }
}
