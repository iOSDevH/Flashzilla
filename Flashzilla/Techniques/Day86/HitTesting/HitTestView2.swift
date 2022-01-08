//
//  HitTestView2.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import SwiftUI

struct HitTestView2: View {
    var body: some View {
        VStack {
            Text("Hello")
            
            Spacer().frame(height: 100)
            
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

struct HitTestView2_Previews: PreviewProvider {
    static var previews: some View {
        HitTestView2()
    }
}
