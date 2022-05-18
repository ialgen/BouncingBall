//
//  GameViewController.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    var bannerView: GADBannerView!
    var interstitialAd: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()

        authenticatePlayer()
        //initBanner()
        //createAndLoadInterstitialAd()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill

            // Present the scene
            view.presentScene(scene)

            view.ignoresSiblingOrder = true

            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local

        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            } else {
                print(localPlayer.isAuthenticated)
            }
        }
    }

    func saveHighscore(score: Int) {
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "boingHighscore")
            scoreReporter.value = Int64(score)

            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }

    func saveTotalScore(score: Int) {
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "boingTotalScore")
            scoreReporter.value = Int64(score)

            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }

    func showLeaderboard() {
        let GCViewController = GKGameCenterViewController()
        GCViewController.gameCenterDelegate = self

        self.present(GCViewController, animated: true, completion: nil)
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
