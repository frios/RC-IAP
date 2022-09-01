//
//  ProgressViewModifier.swift
//  mFood
//
//  Created by Feldy Rios on 10/2/20.
//  Copyright © 2020 Feral Innovations, Inc. All rights reserved.
//

import SwiftUI

struct ProgressViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(1.5, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
    }
}

extension View {
    func progressStyle() -> some View {
        self.modifier(ProgressViewModifier())
    }
}
