//
//  MoveToBackgroundView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

struct MoveToBackgroundView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello World")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct MoveToBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        MoveToBackgroundView()
    }
}
