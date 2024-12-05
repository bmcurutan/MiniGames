//
//  GamesViewController.swift
//  GuessTheFunko
//
//  Created by Bianca Curutan on 12/5/24.
//

import UIKit

class GamesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Matching Game"
        case 1:
            cell.textLabel?.text = "Rows Game"
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(MatchingViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(RowsViewController(), animated: true)
        default:
            break
        }
    }
}
