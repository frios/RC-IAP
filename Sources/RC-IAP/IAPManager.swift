//
//  IAPManager.swift
//
//
//  Created by Ferdinand Rios on 10/20/21.
//

import Purchases

public class IAPManager: ObservableObject {
    static let shared = IAPManager()

    @Published var packages: [Purchases.Package] = []
    @Published var inPaymentProgress = false

    public init(){}
    
    public init(apiKey: String, logLevel: Purchases.LogLevel) {
        Purchases.logLevel = logLevel
        Purchases.configure(withAPIKey: apiKey)
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
