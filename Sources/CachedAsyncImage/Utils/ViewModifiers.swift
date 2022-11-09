//
//  ViewModifiers.swift
//  CachedAsyncImage
//
//  Created by Miguel Ferrer Fornali on 9/11/22.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)
    
    init(perform action: @escaping (() -> Void)) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action()
            }
        }
    }
}
