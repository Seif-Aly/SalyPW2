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
        static let wishesKey = "wishesKey"
        
        static let tableViewIndex: Int = 1
        
        static let bottomLabel: Double = 10
        static let leftLabel: Double = 60
        static let textLabel: String = "Swipe left on wishes to delete"
        static let colorLabel: UIColor = .white
        
    }
    
    private let table: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    private var wishArray: [String]!
    private var labelView = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = Constants.wishesColor
        configureTable()
        wishArray = (defaults.array(forKey: Constants.wishesKey) as? [String]) ?? []
        configureLabel()
    }
}
// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return Constants.tableViewIndex
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
        table.delegate = self
    }
    
    func newWishAdded(wish: String) {
        wishArray.append(wish)
        table.reloadData()
        defaults.set(wishArray, forKey: Constants.wishesKey)
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

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    private func configureLabel() {
        view.addSubview(labelView)
        labelView.text = Constants.textLabel
        labelView.textColor = Constants.colorLabel
        labelView.pinBottom(to: table.bottomAnchor, Constants.bottomLabel)
        labelView.pinLeft(to: table.leadingAnchor, Constants.leftLabel)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == Constants.tableViewIndex
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishArray.remove(at: indexPath.row)
            defaults.set(wishArray, forKey: Constants.wishesKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
