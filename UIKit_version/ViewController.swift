import UIKit

final class ViewController: UIViewController {
    var cards: [FunkoCard] = FunkoCard.allCards

    var tapHandler: (Int, FunkoCard, UIButton) -> Void = { _, _, _ in }

    var isMatch: (FunkoCard?, FunkoCard?, UIButton?) = (nil, nil, nil)

    let stackView = UIStackView()

    let resultLabel = UILabel()
    var score: Int = 0 {
        didSet {
            resultLabel.text = "Result: \(score)"
        }
    }

    var isAllFaceUp: Bool {
        return score == FunkoCard.allCards.count / 2
    }

    var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setTitle("Play again", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapHandler =  { idx, card, button in
//            print("TODO: handle UIKit tap")

            if self.isMatch.0 == nil {
                self.isMatch.0 = card
                self.isMatch.2 = button
            } else if self.isMatch.1 == nil {
                self.isMatch.1 = card
            }

            button.setImage(card.uiImage, for: .normal)

            if let match0 = self.isMatch.0, let match1 = self.isMatch.1 {
                if match0.tag == match1.tag {
                    // Do nothing to change card appearance
                    self.score += 1
                } else {
                    // Not match
                    self.isMatch.2!.setImage(FunkoCard.defaultImage, for: .normal)
                    button.setImage(FunkoCard.defaultImage, for: .normal)
                }
                self.isMatch = (nil, nil, nil)
            }

            self.isGameOver()
        }
        
        view.backgroundColor = .white
        drawGameState()
    }

    private func isGameOver() {
        if self.isAllFaceUp {
            resultLabel.text = "Game Over"
            resetButton.isHidden = false
        }
    }
}

extension ViewController {
    func drawGameState() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        let rows: Int = 4
        let columns: Int = 4
        
        for row in 0 ..< rows {
            let horizontalSv = UIStackView()
            horizontalSv.axis = .horizontal
            horizontalSv.alignment = .fill
            horizontalSv.distribution = .fillEqually
            horizontalSv.spacing = 5

            for col in 0 ..< columns {
                let button = UIButton()
                let index = row*columns + col
                let card = cards[index]
                button.setImage(FunkoCard.defaultImage, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.addAction(UIAction(handler: {[weak self] _ in
                    self?.tapHandler(index, card, button)
                }), for: .touchUpInside)
                horizontalSv.addArrangedSubview(button)
            }
            stackView.addArrangedSubview(horizontalSv)
        }

        resultLabel.text = "Result:"
        resultLabel.textAlignment = .center
        stackView.addArrangedSubview(resultLabel)

        view.addSubview(stackView)

        let width = self.view.bounds.width - 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true

        stackView.addArrangedSubview(resetButton)

//        view.addSubview(resetButton)
//        NSLayoutConstraint.activate([
//            resetButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8),
//            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    }

    @objc private func resetGame() {
        resetButton.isHidden = true
        cards.shuffle()

        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }

        drawGameState()
    }
}
