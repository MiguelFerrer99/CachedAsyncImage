//
//  View+Extension.swift
//  CachedAsyncImage
//
//  Created by Miguel Ferrer Fornali on 9/11/22.
//

import SwiftUI

extension View {
    func onLoad(perform action: @escaping (() -> Void)) -> some View {
        self
            .modifier(ViewDidLoadModifier(perform: action))
    }
}
