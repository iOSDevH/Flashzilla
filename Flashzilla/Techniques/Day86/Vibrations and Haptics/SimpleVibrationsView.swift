//
//  SimpleVibrationsView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import SwiftUI

struct SimpleVibrationsView: View {
    var body: some View {
        Text("Hello World")
            .padding()
            .onTapGesture(perform: simpleSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success) // Can use .warning and .error as well
    }
}

struct SimpleVibrationsView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleVibrationsView()
    }
}
