//
//  ReduceMotionView2.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

struct ReduceMotionView2: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale += 1.5
                }
            }
    }
}

struct ReduceMotionView2_Previews: PreviewProvider {
    static var previews: some View {
        ReduceMotionView2()
    }
}
