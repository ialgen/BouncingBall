//
//  GameScene.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//
// swiftlint:disable force_cast

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var balls = [Ball]()
    //var ball: Ball!
    var delayToScore: Int = 0
    var permissionToScore: Bool = false
    var bouncingFist: BouncingFist!
    var borderObstacles = [BorderObstacle]()
    var scoreLabel: ScoreLabel!
    var score: Int = 0
    var noBorderContactScore : Int = 0
    var replayButton: UIButton!
    var menuButton: UIButton!
    var highscoreLabel = HighscoreLabel(fontNamed: helveticaNeue)

    override func didMove(to view: SKView) {
        backgroundColor = .black

        spawnBall()
        spawnFist()
        displayScore()
        spawnBorderObstacles()
        surroundSceneWithBorder()

        physicsWorld.contactDelegate = self
    }

// MARK: - Scene configuration
    func spawnBall() {
        let ball = Ball(texture: SKTexture(imageNamed: "Disk"),
                    color: .white,
                    size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        balls.append(ball)
        addChild(balls.last!)
    }

    func despawnBall(ball: Ball) {
        ball.removeFromParent()
    }

    func spawnFist() {
        bouncingFist = BouncingFist(texture: SKTexture(imageNamed: "Disk"),
                                    color: .white,
                                    size: CGSize(width: 100, height: 100))
        bouncingFist.position = CGPoint(x: frame.midX - 25, y: frame.minY + bouncingFist.size.height)
        addChild(bouncingFist)
    }

    func displayScore() {
        scoreLabel = ScoreLabel(fontNamed: helveticaNeue)
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(scoreLabel)
    }

    func spawnBorderObstacles() {
        let obstaclesSize = CGSize(width: 20, height: frame.height * 0.8)
        let points = [CGPoint(x: frame.minX + obstaclesSize.width / 2, y: frame.midY - obstaclesSize.height / 2),
                      CGPoint(x: frame.minX + obstaclesSize.width / 2, y: frame.midY + obstaclesSize.height / 2),
                      CGPoint(x: frame.maxX - obstaclesSize.width / 2, y: frame.midY - obstaclesSize.height / 2),
                      CGPoint(x: frame.maxX - obstaclesSize.width / 2, y: frame.midY + obstaclesSize.height / 2)]
        for cnt in 1...4 {
            let obstacle = BorderObstacle(texture: nil, color: .white, size: obstaclesSize)
            borderObstacles.append(obstacle)
            borderObstacles[cnt-1].position = points[cnt-1]
        }
        for cnt in 0...3 {
            addChild(borderObstacles[cnt])
        }
    }

    func surroundSceneWithBorder() {
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.categoryBitMask = PhysicsCategories.sceneBorder
        border.restitution = 0
        self.physicsBody = border
    }

// MARK: - GameOver view
    func showReplayView() {
        replayButton = UIButton(frame: CGRect(x: frame.midX - frame.width * 0.25,
                                              y: frame.midY + frame.height / 6,
                                              width: frame.width * 0.5,
                                              height: 40))
        replayButton.backgroundColor = .black
        replayButton.layer.cornerRadius = 20
        replayButton.setTitle("REPLAY", for: .normal)
        replayButton.setTitleColor(.black, for: .normal)
        replayButton.titleLabel?.font = UIFont(name: helveticaNeue, size: 30.0)
        replayButton.addTarget(self, action: #selector(replay), for: .touchUpInside)
        self.view?.addSubview(replayButton)

        menuButton = UIButton(frame: CGRect(x: frame.midX - frame.width * 0.25,
                                            y: frame.midY - frame.height / 5,
                                            width: frame.width * 0.5,
                                            height: 40))
        menuButton.backgroundColor = .black
        menuButton.layer.cornerRadius = 20
        menuButton.setTitle("MENU", for: .normal)
        menuButton.setTitleColor(.black, for: .normal)
        menuButton.titleLabel?.font = UIFont(name: helveticaNeue, size: 30.0)
        menuButton.addTarget(self, action: #selector(menu), for: .touchUpInside)
        self.view?.addSubview(menuButton)

        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - frame.height / 10)

        addChild(highscoreLabel)
        UIView.animate(withDuration: 0.5) {
            self.menuButton.backgroundColor = .white
            self.replayButton.backgroundColor = .white
        }
    }

    @objc func replay() {
        for ob in borderObstacles {
            ob.size.height = frame.height * 0.9
            createNewPhysicsBody(for: ob, with: ob.size)
        }
        score = 0
        scoreLabel.update(with: score)
        spawnBall()
        highscoreLabel.removeFromParent()
        replayButton.removeFromSuperview()
        menuButton.removeFromSuperview()
    }

    @objc func menu() {
        if Int.random(in: 0...10) < 3 {
            (self.view!.window!.rootViewController as! GameViewController).presentInterstitialAd()
        }
        replayButton.removeFromSuperview()
        menuButton.removeFromSuperview()
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }

// MARK: - Physics
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        if contactMask == PhysicsCategories.ball | PhysicsCategories.bouncingFist {
            if (delayToScore > 30) || permissionToScore {
                score += 1
                scoreLabel.update(with: score)
                delayToScore = 0
                permissionToScore = false
            }

            if score % 100 == 0 {
                updateObstaclesSize(for: "scoringFist")
            } else {
                updateObstaclesSize(for: "fist")
            }

            //changeBallVelocity(ball: contact.bodyA.node as! Ball)
            //changeBallVelocity(ball: contact.bodyB.node as! Ball)
            if contact.bodyA.categoryBitMask == PhysicsCategories.ball  {
                changeBallVelocity(ball: contact.bodyA.node as! Ball)
            } else if contact.bodyB.categoryBitMask == PhysicsCategories.ball  {
                changeBallVelocity(ball: contact.bodyB.node as! Ball)
            }

            if score % 20 == 0 {
                spawnBall()
            }
        } else if contactMask == PhysicsCategories.ball | PhysicsCategories.borderObstacle {
            updateObstaclesSize(for: "border")
            permissionToScore = true
        } else if contactMask == PhysicsCategories.ball | PhysicsCategories.sceneBorder {
            if balls.count > 1 {
                if contact.bodyA.categoryBitMask == PhysicsCategories.ball  {
                    contact.bodyA.node?.removeFromParent()
                    balls = balls.filter() { $0 != contact.bodyA.node }
                } else if contact.bodyB.categoryBitMask == PhysicsCategories.ball  {
                    contact.bodyB.node?.removeFromParent()
                    balls = balls.filter() { $0 != contact.bodyB.node }
                }
            } else {
                gameOver()
            }
        }
    }

// MARK: Ball physics
    private func changeBallVelocity(ball: Ball) {
        let norm = sqrt(pow((ball.physicsBody?.velocity.dx)!,2) + pow((ball.physicsBody?.velocity.dy)!,2))
        if norm > 1000 {
            reSpeed(a: 0.7, b: 0.90, ball: ball)
        } else if norm <= 1000 && norm > 600 {
            reSpeed(a: 0.9, b: 1.1, ball: ball)
        } else {
            reSpeed(a: 1.01, b: 1.3, ball: ball)
        }
    }

    private func reSpeed(a: CGFloat, b: CGFloat, ball: Ball) {
        let rand = CGFloat.random(in: a...b)
        ball.physicsBody?.velocity = CGVector(dx: (ball.physicsBody?.velocity.dx)! * rand, dy: (ball.physicsBody?.velocity.dy)! * rand)
    }

// MARK: Obstacles
    private func updateObstaclesSize(for collision: String) {
        switch collision {
        case "border":
            if borderObstacles[0].size.height > 30 {
                for ob in borderObstacles {
                    ob.size.height -= 5
                    createNewPhysicsBody(for: ob, with: ob.size)
                }
            }
        case "fist":
            if borderObstacles[0].size.height > 30 {
                for ob in borderObstacles {
                    ob.size.height -= 2
                    createNewPhysicsBody(for: ob, with: ob.size)
                }
            }
        case "scoringFist":
            for ob in borderObstacles {
                ob.size.height = frame.height * 0.9
                ob.size.height = frame.height * CGFloat(100/pow(Double(score), 0.9))
                createNewPhysicsBody(for: ob, with: ob.size)
            }
        default:
            for ob in borderObstacles {
                ob.size.height += frame.height * 0.8
                createNewPhysicsBody(for: ob, with: ob.size)
            }
        }
    }

    private func createNewPhysicsBody(for ob: BorderObstacle, with size: CGSize) {
        ob.physicsBody = SKPhysicsBody(rectangleOf: size)
        ob.physicsBody?.categoryBitMask = PhysicsCategories.borderObstacle
        ob.physicsBody?.contactTestBitMask = PhysicsCategories.ball
        ob.physicsBody?.collisionBitMask = PhysicsCategories.ball
        ob.physicsBody?.fieldBitMask = PhysicsCategories.none

        ob.physicsBody?.allowsRotation = false
        ob.physicsBody?.affectedByGravity = false
        ob.physicsBody?.isDynamic = false
    }

// MARK: - GameOver
    private func gameOver() {
        if score > UserDefaults.standard.integer(forKey: DefaultKeys.highscore) {
            UserDefaults.standard.set(score, forKey: DefaultKeys.highscore)
            highscoreLabel.update(with: score)
        }

        let total = UserDefaults.standard.integer(forKey: DefaultKeys.totalScore) + score
        UserDefaults.standard.set(total, forKey: DefaultKeys.totalScore)

        let viewController = self.view?.window?.rootViewController as! GameViewController
        viewController.saveHighscore(score: UserDefaults.standard.integer(forKey: DefaultKeys.highscore))
        viewController.saveTotalScore(score: UserDefaults.standard.integer(forKey: DefaultKeys.totalScore))

        balls[0].removeFromParent()
        balls.removeFirst()

        showReplayView()
    }

// MARK: - User touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            bouncingFist.run(SKAction.move(to: CGPoint(x: location.x, y: location.y), duration: 0))
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            bouncingFist.run(SKAction.move(to: CGPoint(x: location.x, y: location.y), duration: 0))
        }
    }

// MARK: - Frame updates
    override func update(_ currentTime: TimeInterval) {
        for cnt in 0...3 {
            updateStateFor(obstacle: borderObstacles[cnt])

            if borderObstacles[cnt].state == "down" {
                borderObstacles[cnt].run(BorderObstaclesActions.moveDown)
            } else {
                borderObstacles[cnt].run(BorderObstaclesActions.moveUp)
            }
        }

        delayToScore += 1
    }

    private func updateStateFor(obstacle: BorderObstacle) {
        if obstacle.position.y > frame.maxY - frame.height / 8 {
            obstacle.state = "down"
        } else if obstacle.position.y < frame.minY + frame.height / 8 {
            obstacle.state = "up"
        }
    }
}
