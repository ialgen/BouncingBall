//
//  Constants.swift
//  BouncingBall
//
//  Created by Ialgen on 01/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ball: UInt32 = 0b0001
    static let bouncingFist: UInt32 = 0b0010
    static let borderObstacle: UInt32 = 0b0100
    static let sceneBorder: UInt32 = 0b1000
}

enum BorderObstaclesActions {
    static let moveUp: SKAction = SKAction.moveBy(x: 0, y: 1, duration: 0)
    static let moveDown: SKAction = SKAction.moveBy(x: 0, y: -1, duration: 0)
}

let helveticaNeue = "HelveticaNeue"

// MARK: - In-App purchases

public let AdsRemoval = "com.IalgenAllal.BouncingBall.AdsRemoval"

// MARK: - UserDefault keys
enum DefaultKeys {
    static let highscore: String = "Highscore"
    static let totalScore: String = "TotalScore"
}

// MARK: - Ads IDs
let appID = "ca-app-pub-3940256099942544~1458002511"
// TestAppID: ca-app-pub-3940256099942544~1458002511
// BoucingBallAppID: ca-app-pub-2674553825448036~1540004427
let bannerID = "ca-app-pub-3940256099942544/2934735716"
// TestBannerID: ca-app-pub-3940256099942544/2934735716
// BannerBlocID: ca-app-pub-2674553825448036/9773717666
let interstitialID = "ca-app-pub-3940256099942544/4411468910"
// TestInterstitialAdID: ca-app-pub-3940256099942544/4411468910
// InterstitialBlocID: ca-app-pub-2674553825448036/3991865808


// MARK: - Skins
let skinsAndShapes = [UIImage: SKPhysicsBody]()
