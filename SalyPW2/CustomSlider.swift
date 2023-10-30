//
//  CustomSlider.swift
//  SalyPW2
//
//  Created by seif on 2023-10-03.
//

import UIKit

final class CustomSlider: UIView {
    private enum Constants{
        static let sliderTitleTop: CGFloat = 20
        static let sliderTitleRight: CGFloat = 20
        static let sliderOfSliderBottom: CGFloat = -10
        static let sliderOfSliderRight: CGFloat = 20
    }
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
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sliderTitleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderTitleRight),
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.sliderOfSliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderOfSliderRight)
        ])
    }
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
