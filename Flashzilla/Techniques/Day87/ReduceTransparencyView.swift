//
//  ReduceTransparencyView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

struct ReduceTransparencyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text("Hello World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ReduceTransparencyView_Previews: PreviewProvider {
    static var previews: some View {
        ReduceTransparencyView()
.previewInterfaceOrientation(.landscapeRight)
    }
}
