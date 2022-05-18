//
//InterstitialAd.swift
//  BouncingBall
//
//  Created by Ialgen on 05/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation
import GoogleMobileAds

extension GameViewController: GADInterstitialDelegate {

    func createAndLoadInterstitialAd() {
        interstitialAd = GADInterstitial(adUnitID: interstitialID)
        interstitialAd.delegate = self
        interstitialAd.load(GADRequest())
    }

    func presentInterstitialAd() {
        if interstitialAd != nil && interstitialAd.isReady {
            interstitialAd.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }

    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        createAndLoadInterstitialAd()
        print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
