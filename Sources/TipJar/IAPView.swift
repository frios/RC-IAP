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
    
    public init(){}

    public var body: some View {
        VStack {
            Text("Tip Jar")
                .font(.largeTitle)
                .padding(.horizontal)
            
            Image("Tip Jar")
                .resizable()
                .frame (width: 200, height: 200, alignment: .center)

            VStack(alignment: .leading) {
                Text("I am a lone developer who does this for the love of coding. If you love the app, please leave a tip to help with my development costs. Any tip at all helps a lot. Thank you.")
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
        IAPView().environmentObject(IAPManager())
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
