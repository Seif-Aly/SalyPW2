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
        static let sliderBottom: CGFloat = -10
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
        
        static let title = "Wish Maker"
        static let description = "Our app will make all your dreams true!"
        static let red = "Red"
        static let blue = "Blue"
        static let green = "Green"
    }
    private var stack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        configureDescription(below: configureTitle())
        configureSliders()
        configureButton()
    }
    
    private func configureButton(){
        let myButton = UIButton()
        myButton.setTitle("Hide Slider", for: .normal)
        myButton.setTitleColor(.systemPink, for: .normal)
        myButton.backgroundColor = .white
        myButton.layer.cornerRadius = Constants.cornerRadius
        myButton.layer.borderWidth = Constants.borderWidth
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.addTarget(self, action:#selector(hideSlider), for: .touchUpInside)
        

        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            myButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            myButton.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: Constants.buttonBottom)
        ])
    }
   
    @objc func hideSlider(){
        stack.isHidden = !stack.isHidden
        
    }

    private func configureTitle() -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.title
        //title.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
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
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sliderRight),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.sliderBottom)
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
        self.stack = stack
    }
}
