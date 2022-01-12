//
//  Card.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
