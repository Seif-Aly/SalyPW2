//
//  CustomSlider.swift
//  SalyPW2
//
//  Created by seif on 2023-10-03.
//

import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: WishMakerViewController.Constants.sliderTitleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: WishMakerViewController.Constants.sliderTitleRight),
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: WishMakerViewController.Constants.sliderOfSliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: WishMakerViewController.Constants.sliderOfSliderRight)
        ])
    }
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
