//
//  ViewController.swift
//  SalyPW2
//
//  Created by seif on 2023-10-02.
//

import UIKit

final class WishMakerViewController: UIViewController {
    enum Constants{
        static let titleFontSize: CGFloat = 32
        static let descriptionFontSize: CGFloat = 20
        static let titleRight: CGFloat = 20
        static let titleTop: CGFloat = 30
        static let descriptionRight: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        static let sliderRadius: CGFloat = 20
        static let sliderMin: CGFloat = 0
        static let sliderMax: CGFloat = 1
        static let sliderRight: CGFloat = 20
        static let sliderBottom: CGFloat = -20
        static let colorOpacity: CGFloat = 1.0
        static let sliderTitleTop: CGFloat = 20
        static let sliderTitleRight: CGFloat = 20
        static let sliderOfSliderBottom: CGFloat = -10
        static let sliderOfSliderRight: CGFloat = 20
        static let cornerRadius: CGFloat = 10.0
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 70
        static let buttonWidth: CGFloat = 100
        static let buttonBottom: CGFloat = -20
        static let wishButtonHeight: CGFloat = 70
        static let wishButtonBottom: CGFloat = 20
        static let wishButtonRadius: CGFloat = 10.0
        static let wishButtonSide: CGFloat = 20
        
        static let title = "Wish Maker"
        static let wishButtonText = "My wish"
        static let description = "Our app will make all your dreams true!"
        static let red = "Red"
        static let blue = "Blue"
        static let green = "Green"
    }
    
    private var sliderStack: UIStackView!
    private let addHideButton: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        configureDescription(below: configureTitle())
        configureSliders()
        ConfigureaddHideButton()
        configureAddWishButton()
    }
    
    private func ConfigureaddHideButton(){
        addHideButton.setTitle("Hide Slider", for: .normal)
        addHideButton.setTitleColor(.systemPink, for: .normal)
        addHideButton.backgroundColor = .white
        addHideButton.layer.cornerRadius = Constants.cornerRadius
        addHideButton.layer.borderWidth = Constants.borderWidth
        addHideButton.translatesAutoresizingMaskIntoConstraints = false
        addHideButton.addTarget(self, action:#selector(hideSlider), for: .touchUpInside)
        view.addSubview(addHideButton)
        NSLayoutConstraint.activate([
            addHideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addHideButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            addHideButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            addHideButton.bottomAnchor.constraint(equalTo: sliderStack.topAnchor, constant: Constants.buttonBottom)
        ])
    }
    
    @objc func hideSlider(){
        sliderStack.isHidden = !sliderStack.isHidden
    }
    
    private func configureTitle() -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.title
        title.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        title.textColor = UIColor.systemRed
        
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
        
        return title
    }
    
    private func configureDescription(below titleLabel: UILabel) {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.description
        description.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        description.textColor = UIColor.white
        
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionRight),
            description.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTop),
            description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
        ])
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.sliderRadius
        stack.clipsToBounds = true
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        view.addSubview(addWishButton)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sliderRight),
            stack.bottomAnchor.constraint(equalTo: addWishButton.topAnchor, constant: Constants.sliderBottom)
        ])
        sliderRed.valueChanged = { [weak self] value in
            let red = CGFloat(value)
            let blue = CGFloat(sliderBlue.slider.value)
            let green = CGFloat(sliderGreen.slider.value)
            self?.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.colorOpacity)
        }
        sliderBlue.valueChanged = { [weak self] value in
            let red = CGFloat(sliderRed.slider.value)
            let blue = CGFloat(value)
            let green = CGFloat(sliderGreen.slider.value)
            self?.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.colorOpacity)
        }
        sliderGreen.valueChanged = { [weak self] value in
            let red = CGFloat(sliderRed.slider.value)
            let blue = CGFloat(sliderBlue.slider.value)
            let green = CGFloat(value)
            self?.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.colorOpacity)
        }
        self.sliderStack = stack
    }
    private func configureAddWishButton () {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.wishButtonHeight)
        addWishButton.pinBottom(to: view, Constants.wishButtonBottom)
        addWishButton.pinHorizontal(to: view, Constants.wishButtonSide)
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.wishButtonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.wishButtonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    @objc
    private func addWishButtonPressed(){
        present(WishStoringViewController(), animated: true)
    }
}
