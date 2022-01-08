//
//  HitTestView1.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import SwiftUI

struct HitTestView1: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
                //.allowsHitTesting(false)
        }
    }
}

struct HitTestView1_Previews: PreviewProvider {
    static var previews: some View {
        HitTestView1()
    }
}
