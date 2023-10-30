//
//  WishStoringViewController.swift
//  SalyPW2
//
//  Created by seif on 2023-10-30.
//

import UIKit

final class WishStoringViewController: UIViewController{
    private enum Constants{
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        static let cellNumber = 25
    }
    private let table: UITableView = UITableView(frame: .zero)
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
}
// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource{
    private func configureTable() {
     view.addSubview(table)
     table.backgroundColor = .red
     table.dataSource = self
     table.separatorStyle = .none
     table.layer.cornerRadius = Constants.tableCornerRadius

     table.pin(to: view, Constants.tableOffset)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.cellNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "Row \(indexPath.row)"
            return cell
    }
    
    
}
