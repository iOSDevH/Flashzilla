//
//  PriorityGestureView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import SwiftUI

struct PriorityGestureView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Hello, world 1")
                    .onTapGesture {
                        print("Text Tapped!")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        print("Hstack 1 tapped!")
                    }
            )
            
            Spacer ()
            
            HStack {
                Text("Hello, world 2")
                    .onTapGesture {
                        print("Text Tapped!")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        print("Hstack 2 tapped!")
                    }
            )
            
            Spacer()
        }
        .padding()
            
    }
}

struct PriorityGestureView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityGestureView()
    }
}
