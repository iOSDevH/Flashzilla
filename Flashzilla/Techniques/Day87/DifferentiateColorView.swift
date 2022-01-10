//
//  DifferentiateColorView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

struct DifferentiateColorView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct DifferentiateColorView_Previews: PreviewProvider {
    static var previews: some View {
        DifferentiateColorView()
    }
}
