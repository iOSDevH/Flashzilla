//
//  ContinousVibrationView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import CoreHaptics
import SwiftUI

struct ContinousVibrationView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Tap to vibrate")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    prepareHaptics()
                }
            }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        //let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 0.5)
        events.append(event)
         
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct ContinousVibrationView_Previews: PreviewProvider {
    static var previews: some View {
        ContinousVibrationView()
    }
}
