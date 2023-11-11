//
//  AddWishCell.swift
//  SalyPW2
//
//  Created by seif on 2023-11-11.
//

import UIKit

class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    private enum Constants{
        static let fontSizeText: CGFloat = 14
        static let radiusText: CGFloat = 14
        static let colorText: UIColor = .white
        
        static let radiusButton: CGFloat = 14
        static let fontSizeButton: CGFloat = 14
        static let heightButton: CGFloat = 30
        static let colorButton: UIColor = .systemGray6
        
        
        static let stackSpace: CGFloat = 8
        static let stackPin: CGFloat = 15
        static let colorStack: UIColor = .systemYellow
        
    }
    var addWish: ((String) -> ())?
    private var textView = UITextView()
    private var addWishButton = UIButton()
    private var stackView = UIStackView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        textView.font = .systemFont(ofSize: Constants.fontSizeText)
        textView.backgroundColor = Constants.colorText
        textView.layer.cornerRadius = Constants.radiusText
        textView.setHeight(Constants.heightButton)
        
        addWishButton.setTitle("Please add your new wish", for: .normal)
        addWishButton.titleLabel?.font = .systemFont(ofSize: Constants.fontSizeButton)
        addWishButton.setTitleColor(.systemIndigo, for: .normal)
        addWishButton.backgroundColor = Constants.colorButton
        addWishButton.layer.cornerRadius = Constants.radiusButton
        addWishButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        addWishButton.isEnabled = true
        
        stackView = UIStackView(arrangedSubviews: [textView, addWishButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpace
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, Constants.stackPin)
        contentView.backgroundColor = Constants.colorStack
    }
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        let userWish = self.textView.text!
        if(!userWish.isEmpty){
            addWish!(userWish)
        }
        textView.text = ""
    }
}
