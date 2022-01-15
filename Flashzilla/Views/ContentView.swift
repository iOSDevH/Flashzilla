//
//  ContentView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-08.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject private var cardsVM = CardViewModel(permanentDeletion: false)
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    //@State private var cardsAreEmpty = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cardsVM.cards, id: \.id) { card in
                        CardView(card: card) { isCorrectAnswer in
                            withAnimation {
                                removeCard(at: cardsVM.cards.firstIndex(of: card)!, isCorrectanswer: isCorrectAnswer )
                            }
                        }
                        .stacked(at: cardsVM.cards.firstIndex(of: card)!, in: cardsVM.cards.count)
                        .allowsHitTesting(card == cardsVM.cards.last)
                        .accessibilityHidden(card != cardsVM.cards.last)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cardsVM.cards.isEmpty {
                    Button("\(cardsVM.cardsAreEmpty ? "Add Card" : "Start Again")") {
                        if cardsVM.cardsAreEmpty {
                            showingEditScreen = true
                        } else {
                            resetCards()
                        }
                        
                        
                    }
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cardsVM.cards.count - 1, isCorrectanswer: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cardsVM.cards.count - 1, isCorrectanswer: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                        
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cardsVM.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .onChange(of: showingEditScreen) { _ in
            if showingEditScreen == false {
                resetCards()
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear(perform: resetCards)
        
    }
    
    func removeCard(at index: Int, isCorrectanswer: Bool) {
        cardsVM.removeCard(at: index, isCorrectanswer: isCorrectanswer)
        if cardsVM.cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        cardsVM.loadData()
        if cardsVM.cardsAreEmpty {
            isActive = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
