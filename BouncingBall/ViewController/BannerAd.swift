//
//  BannerAd.swift
//  BouncingBall
//
//  Created by Ialgen on 03/05/2019.
//  Copyright © 2019 Ialgen. All rights reserved.
//

import Foundation
import GoogleMobileAds

extension GameViewController: GADBannerViewDelegate {

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bannerView)
        self.view.addConstraints([NSLayoutConstraint(item: bannerView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: view.safeAreaLayoutGuide,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: 0),
                                   NSLayoutConstraint(item: bannerView,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .centerX,
                                                      multiplier: 1,
                                                      constant: 0)])
    }

    func initBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = bannerID
        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {

        // Add banner to view and add constraints as above.
        addBannerViewToView(bannerView)

        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
