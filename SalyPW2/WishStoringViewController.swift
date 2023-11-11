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
        static let wishesKey: String = "wishesKey"
        
        static let tableViewIndex: Int = 1
        
        static let bottomLabel: Double = 10
        static let textLabel: String = "Swipe left on wishes to delete or edit"
        static let colorLabel: UIColor = .white
        
        static let editTitle: String = "Edit"
        static let deleteTitle: String = "Delete"
        static let cancelTitle: String = "Cancel"
        static let saveTitle: String = "Save"
        static let editPlaceHolder: String = "Please enter your wish"
        
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
        labelView.pinCenterX(to: table.centerXAnchor)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == Constants.tableViewIndex
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == Constants.tableViewIndex else {
            return nil
        }
        
        let editAction = UIContextualAction(style: .normal, title: Constants.editTitle) { [weak self] (_, _, completion) in
            self?.editWish(at: indexPath)
            completion(true)
        }
        editAction.backgroundColor = .systemBlue
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.deleteTitle) { [weak self] (_, _, completion) in
            self?.deleteWish(at: indexPath)
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
    
    private func deleteWish(at indexPath: IndexPath) {
        wishArray.remove(at: indexPath.row)
        defaults.set(wishArray, forKey: Constants.wishesKey)
        table.deleteRows(at: [indexPath], with: .fade)
    }
    
    private func editWish(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: Constants.editTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = Constants.editPlaceHolder
            textField.text = self.wishArray[indexPath.row]
        }
        
        let cancelAction = UIAlertAction(title: Constants.cancelTitle, style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: Constants.saveTitle, style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let newWish = textField.text,
                  !newWish.isEmpty else {
                return
            }
            
            self?.wishArray[indexPath.row] = newWish
            self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
            self?.table.reloadRows(at: [indexPath], with: .automatic)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
