//
//  ReduceMotionView1.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

struct ReduceMotionView1: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello World!")
            .scaleEffect(scale)
            .onTapGesture {
                if reduceMotion {
                    scale += 1.5
                } else {
                    withAnimation {
                        scale += 1.5
                    }
                }
            }
    }
}

struct ReduceMotionView1_Previews: PreviewProvider {
    static var previews: some View {
        ReduceMotionView1()
    }
}
