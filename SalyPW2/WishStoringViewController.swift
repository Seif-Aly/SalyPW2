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
        static let numOfSections: Int = 2
        static let wishesColor: UIColor = .black
        static let tableColor: UIColor = .systemTeal
        
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    override func viewDidLoad() {
        view.backgroundColor = Constants.wishesColor
        configureTable()
    }
}
// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        else{
            return wishArray.count
        }
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = Constants.tableColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    func newWishAdded(wish: String) {
        wishArray.append(wish)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
                as? AddWishCell{
                cell.addWish = newWishAdded
                return cell
            }
        }
        else
        {
            let wish = wishArray[indexPath.row]
            if let wishCell = table.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as? WrittenWishCell{
                wishCell.configure(with: wish)
                return wishCell
            }
        }
        return UITableViewCell()
    }
}
