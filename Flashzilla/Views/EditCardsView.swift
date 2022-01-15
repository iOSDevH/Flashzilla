//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-11.
//

// 1. Needs an array of cards to work with
// 2. NavigationView wrapped around with a Done button to dismiss the view
// 3. List of all the cards the user added previously
// 4. Swipe to delete for the cards
// 5. Section at the top to add new cards, prompt and answer
// 6. Method to load and save data to UserDefaults

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var editVM = CardViewModel(permanentDeletion: true)
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button {
                        addCard(prompt: newPrompt, answer: newAnswer)
                    } label: {
                        Text("Add Card")
                    }
                }
                
                Section {
                    ForEach(editVM.cards, id: \.id) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .padding()
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: editVM.loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func addCard(prompt: String, answer: String) {
        editVM.addCard(prompt: newPrompt, answer: newAnswer)
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        for i in offsets {
            editVM.removeCard(at: i)
        }
    }
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
