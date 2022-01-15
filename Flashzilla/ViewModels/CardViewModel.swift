//
//  CardViewModel.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-15.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card]
    var cardsAreEmpty = true
    
    let permanentDeletion: Bool
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
    
    init(permanentDeletion: Bool) {
        cards = [Card]()
        self.permanentDeletion = permanentDeletion
        loadData()
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
            if cards.isEmpty {
                cardsAreEmpty = true
            } else {
                cardsAreEmpty = false
            }
        } catch {
            cards = []
            cardsAreEmpty = true
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addCard(prompt: String, answer: String) {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func removeCard(at index: Int, isCorrectanswer: Bool = true) {
        guard index >= 0 else { return }
        
        if isCorrectanswer == false {
            let card = Card(prompt: cards[index].prompt, answer: cards[index].answer)
            cards.remove(at: index)
            cards.insert(card, at: 0)
        } else {
            cards.remove(at: index)
        }
        
        if permanentDeletion {
            saveData()
        }
    }
    
    
}
