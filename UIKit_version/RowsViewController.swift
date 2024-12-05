//
//  RowsViewController.swift
//  GuessTheFunko
//
//  Created by Bianca Curutan on 12/5/24.
//

import UIKit

class RowsViewController: UIViewController {

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rows Game"
        view.backgroundColor = .white

        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        for i in 0..<5 {

            let horizontalStackView: UIStackView = {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = 8
                stackView.tag = i
                stackView.translatesAutoresizingMaskIntoConstraints = false
                return stackView
            }()

            for j in 0..<5 {
                let button = GridButton()
                button.tag = j
                button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: 40),
                    button.heightAnchor.constraint(equalToConstant: 40)
                ])

                horizontalStackView.addArrangedSubview(button)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }

            verticalStackView.addArrangedSubview(horizontalStackView)
        }
    }

    @objc private func buttonTapped(_ sender: GridButton) {
        var i = -1
        var j = -1

        verticalStackView.arrangedSubviews.forEach { horizontalStackView in
            if let horizontalStackView = horizontalStackView as? UIStackView {
                if horizontalStackView.arrangedSubviews.contains(sender) {
                    i = horizontalStackView.tag
                    j = sender.tag
                    horizontalStackView.arrangedSubviews.forEach { button in
                        if let button = button as? GridButton {
                            button.toggle()
                        }
                    }
                }
            }
        }

        for (k, hStack) in verticalStackView.arrangedSubviews.enumerated() {
            if let hStack = hStack as? UIStackView,
               let button = hStack.arrangedSubviews[j] as? GridButton {
                if k != i {
                    button.toggle()
                }
            }
        }
    }
}

private class GridButton: UIButton {
    private var background: UIColor = .red {
        didSet {
            backgroundColor = background
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle() {
        background = background == .red ? .blue : .red
    }
}
