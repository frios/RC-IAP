//
//  IAPManager.swift
//
//
//  Created by Ferdinand Rios on 10/20/21.
//

import Observation
import RevenueCat

@Observable
public class IAPManager {
    static let shared = IAPManager()

    var packages: [RevenueCat.Package] = []
    var inPaymentProgress = false

    public init(){}
    
    public init(apiKey: String, logLevel: RevenueCat.LogLevel) {
        Purchases.logLevel = logLevel
        Purchases.configure(withAPIKey: apiKey)
        Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
            }
        }
    }

    public func purchase(product: RevenueCat.Package) {
        guard !inPaymentProgress else { return }
        inPaymentProgress = true
        Purchases.shared.purchase(package: product) { (_, purchaserInfo, _, _) in
            self.inPaymentProgress = false
        }
    }
}
