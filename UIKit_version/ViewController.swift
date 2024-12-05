import UIKit

final class ViewController: UIViewController {

    let viewModel = ViewModel()

    var tapHandler: (Int, FunkoCard, UIButton) -> Void = { _, _, _ in }

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "Result:"
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()

    var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setTitle("Play again?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tapHandler =  { [weak self] idx, card, button in
            button.setImage(card.uiImage, for: .normal)

            switch self?.viewModel.hasMatch(idx, card, button) {
            case true:
                if let firstFlippedButton = self?.viewModel.firstFlipped?.2 {
                    firstFlippedButton.isUserInteractionEnabled = false
                    button.isUserInteractionEnabled = false
                }
                self?.viewModel.firstFlipped = nil
            case false:
                if let firstFlippedButton = self?.viewModel.firstFlipped?.2 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        firstFlippedButton.setImage(FunkoCard.defaultImage, for: .normal)
                        button.setImage(FunkoCard.defaultImage, for: .normal)
                    }
                }
                self?.viewModel.firstFlipped = nil
            default:
                break
            }

            self?.showGameState()
        }

        view.backgroundColor = .white
        drawGameState()
    }

    private func showGameState() {
        resultLabel.text = "Result: \(viewModel.score)"

        if viewModel.isGameOver {
            resultLabel.text = "Game Over"
            resetButton.isHidden = false
        }
    }

    private func drawGameState() {
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
                let index = row * columns + col
                let card = viewModel.cards[index]
                button.setImage(FunkoCard.defaultImage, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.addAction(UIAction(handler: {[weak self] _ in
                    self?.tapHandler(index, card, button)
                }), for: .touchUpInside)
                horizontalSv.addArrangedSubview(button)
            }
            stackView.addArrangedSubview(horizontalSv)
        }
        stackView.addArrangedSubview(resultLabel)

        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 20).isActive = true
        stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0).isActive = true

        view.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    }

    @objc private func resetGame() {
        resultLabel.text = "Result:"
        resetButton.isHidden = true
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }

        viewModel.reset()
        drawGameState()
    }
}
