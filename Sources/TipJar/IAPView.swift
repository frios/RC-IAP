//
//  IAPView.swift
//
//
//  Created by Ferdinand Rios on 10/20/21.
//

import Purchases
import SwiftUI

public struct IAPView: View {
    @EnvironmentObject private var iapManager: IAPManager
    
    private var title : String
    private var message : String
    private var imageName : String

    public init(title: String = "Tip Jar", imageName: String = "", message: String = "Please support my development efforts") {
        self.title = title
        self.imageName = imageName
        self.message = message
    }

    public var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding(.horizontal)
            
            if imageName == "" {
                Image("Tip Jar", bundle: .module)
                    .resizable()
                    .frame (width: 200, height: 200, alignment: .center)
            } else {
                Image(imageName)
                    .resizable()
                    .frame (width: 200, height: 200, alignment: .center)
            }

            VStack(alignment: .leading) {
                Text(message)
                    .multilineTextAlignment(.center)
            }
            .padding()

            List {
                ForEach(iapManager.packages, id: \.identifier) { product in
                    Button(action: {
                        iapManager.purchase(product: product)
                    }) {
                        IAPRow(product: product)
                    }
                }
            }
        }
    }
}

struct IAPView_Previews: PreviewProvider {
    static var previews: some View {
        IAPView()
    }
}

public struct IAPRow: View {
    var product: Purchases.Package

    public var body: some View {
        HStack (alignment: .top){
            Image(systemName: "dollarsign.square.fill")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(product.product.localizedTitle).bold()
                Text(product.product.localizedDescription)
            }

            Spacer()
            
            Text(product.localizedPriceString).bold()
                .frame(alignment: .trailing)
        }
    }
}
