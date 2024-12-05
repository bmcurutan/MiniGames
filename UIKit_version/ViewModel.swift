//
//  ViewModel.swift
//  GuessTheFunko
//
//  Created by Bianca Curutan on 12/5/24.
//

import UIKit

class ViewModel {

    private(set) var cards: [FunkoCard] = FunkoCard.allCards
    private(set) var score: Int = 0
    var firstFlipped: (Int, FunkoCard, UIButton)?

    var isGameOver: Bool {
        return score == cards.count / 2
    }

    func reset() {
        cards = cards.shuffled()
    }

    func hasMatch(_ index: Int, _ card: FunkoCard, _ button: UIButton) -> Bool? {
        guard let firstFlippedCard = firstFlipped?.1 else {
            firstFlipped = (index, card, button)
            return nil
        }

        if card.tag == firstFlippedCard.tag {
            score += 1
            return true
        } else {
            return false
        }
    }
}
