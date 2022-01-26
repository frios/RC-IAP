//
//  IAPManager.swift
//  LocationApp
//
//  Created by Ferdinand Rios on 10/20/21.
//


import SwiftUI
import Purchases

public class IAPManager: ObservableObject {
    static let shared = IAPManager()

    @Published var packages: [Purchases.Package] = []
    @Published var inPaymentProgress = false

    public init() {
        Purchases.logLevel = .debug     //debugLogsEnabled = true
        Purchases.configure(withAPIKey: globalConstants.revenueCatAPIKey)
        Purchases.shared.offerings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
            }
        }
    }

    public func purchase(product: Purchases.Package) {
        guard !inPaymentProgress else { return }
        inPaymentProgress = true
        Purchases.shared.purchasePackage(product) { (_, purchaserInfo, _, _) in
            self.inPaymentProgress = false
        }
    }
}
