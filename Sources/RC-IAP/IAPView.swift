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
    private var message : String?
    private var imageName : String?
    private var renderingMode : Image.TemplateRenderingMode

    public init(title: String = "In-App Purchases", imageName: String? = nil, renderingMode: Image.TemplateRenderingMode  = .original, message: String? = nil) {
        self.title = title
        self.imageName = imageName
        self.renderingMode = renderingMode
        self.message = message
    }

    public var body: some View {
        ScrollView {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .padding(.horizontal)
                
                if let imageName = self.imageName {
                    Image(imageName)
                        .resizable()
                        .renderingMode(self.renderingMode)
                        .frame (width: 150, height: 150, alignment: .center)
                        .foregroundColor(Color("AccentColor"))
                } else {
                    Image(systemName: "dollarsign.circle")
                        .renderingMode(.template)
                        .resizable()
                        .frame (width: 150, height: 150, alignment: .center)
                }
                
                if let message = self.message {
                    VStack(alignment: .leading) {
                        Text(message)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    VStack(alignment: .leading) {
                        Text("Here are all of our in-app purchases.")
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
                
//                List {
                    ForEach(iapManager.packages, id: \.identifier) { product in
                        Button(action: {
                            iapManager.purchase(product: product)
                        }) {
                            IAPRow(product: product)
                        }
                    }
                    .padding()
//                }
            }
        }
    }
}

struct IAPView_Previews: PreviewProvider {
    static var iap = IAPManager()
    
    static var previews: some View {
        IAPView()
            .environmentObject(iap)
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
                Text(product.product.localizedDescription).multilineTextAlignment(.leading)
            }

            Spacer()
            
            Text(product.localizedPriceString).bold()
                .frame(alignment: .trailing)
        }
    }
}
