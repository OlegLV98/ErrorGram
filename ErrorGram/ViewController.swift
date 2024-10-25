//
//  ViewController.swift
//  HW11UIKit_LesnoyOleg
//
//  Created by Oleg Lesnoy on 16.05.2024.
//

import UIKit
import Lottie

final class ViewController: UIViewController {

    let items = ["Empty", "Man", "Woman", "Dog", "Cat"]
    let itemsImage = ["", "man", "woman", "dog", "cat"]
    lazy var redColor: CGFloat = 0
    lazy var greenColor: CGFloat = 0
    lazy var blueColor: CGFloat = 0
    
    private lazy var lottieAnimationView: LottieAnimationView = {
        $0.backgroundColor = .none
        $0.animation = LottieAnimation.named("like")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.frame.size = CGSize(width: view.frame.width - 60, height: view.frame.width - 60)
        $0.center = view.center
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.loopMode = .playOnce
        return $0
    }(LottieAnimationView())
    
    private lazy var nameLabel = AppUI.createLabel(text: "ErrorGram", fontSize: 30)

    private lazy var scrollView: UIScrollView = {
        $0.contentInsetAdjustmentBehavior = .never
        $0.bounces = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView(frame: view.frame))
    
    private lazy var scrollContentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
        return $0
    }(UIView())
    private lazy var sunImageView = AppUI.createImageView(image: "sun.max.fill", tintColor: .systemYellow)

    private lazy var moonImageView = AppUI.createImageView(image: "moon.fill", tintColor: #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1))
    
    private lazy var themeSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.onTintColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
        $0.thumbTintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        $0.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        $0.layer.cornerRadius = 15.5
        $0.isOn = false
        $0.addTarget(self, action: #selector(changeMode), for: .valueChanged)
        return $0
    }(UISwitch())
    
    private lazy var mainImageView: UIImageView = {
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: #selector(like))
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addGestureRecognizer(doubleTapGesture)
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        return $0
    }(UIImageView())
    
    @objc func like(sender: UIImageView) {
        lottieAnimationView.isHidden = false
        lottieAnimationView.play { [weak self]_ in
            self?.lottieAnimationView.isHidden = true
        }
    }
    
    private lazy var segmentControlLabel = AppUI.createLabel(text: "Choose a photo")

    private lazy var segmentControl: UISegmentedControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(changeImage), for: .valueChanged)
        $0.tintColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8392156863, alpha: 1)
        $0.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1),
            .font: UIFont(name: "Avenir-MediumOblique", size: 15)
                                               ?? .systemFont(ofSize: 15)], for: .normal)
        return $0
    }(UISegmentedControl(items: items))
    
    private lazy var cornerRadiusSliderLabel = AppUI.createLabel(text: "Corner radius")

    private lazy var settingCornerRadiusSlider = AppUI.createSlider(maximumValue: 50, value: 20, target: self, action: #selector(changeCornerRadius))

    private lazy var borderWidthSliderLabel = AppUI.createLabel(text: "Border width")

    private lazy var settingBorderWidthSlider = AppUI.createSlider(maximumValue: 5, value: 2, target: self, action: #selector(changeBorderWidth))
    
    private lazy var borderColorSliderLabel = AppUI.createLabel(text: "Border Color")
    
    private lazy var colorView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 15
        $0.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        return $0
    }(UIView())
    
    private lazy var colorSliderStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        $0.addArrangedSubview(settingBorderRedColorSlider)
        $0.addArrangedSubview(settingBorderGreenColorSlider)
        $0.addArrangedSubview(settingBorderBlueColorSlider)
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .equalCentering
        return $0
    }(UIStackView())
    
    private lazy var settingBorderRedColorSlider = AppUI.createSlider(thumbTintColor: .red, target: self, action: #selector(changeRedColor))

    private lazy var settingBorderGreenColorSlider = AppUI.createSlider(thumbTintColor: .green, target: self, action: #selector(changeGreenColor))
    
    private lazy var settingBorderBlueColorSlider = AppUI.createSlider(thumbTintColor: .blue, target: self, action: #selector(changeBlueColor))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        [sunImageView, moonImageView, themeSwitch, nameLabel, mainImageView,
         segmentControlLabel, segmentControl, cornerRadiusSliderLabel, settingCornerRadiusSlider,
         borderWidthSliderLabel, settingBorderWidthSlider, borderColorSliderLabel, colorView,
         lottieAnimationView].forEach {
            scrollContentView.addSubview($0)
        }
        
        colorView.addSubview(colorSliderStack)
        setConstraints()
    }
    
    @objc private func changeMode(sender: UISwitch) {
        if sender.isOn {
            mainImageView.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
            themeSwitch.thumbTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            scrollContentView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
            
            sunImageView.tintColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
            moonImageView.tintColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            nameLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            
            segmentControlLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            borderWidthSliderLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            borderColorSliderLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            cornerRadiusSliderLabel.textColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            
            settingBorderWidthSlider.thumbTintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            settingBorderWidthSlider.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            settingBorderWidthSlider.backgroundColor = .none
            
            settingCornerRadiusSlider.thumbTintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            settingCornerRadiusSlider.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            settingCornerRadiusSlider.backgroundColor = .none
            
            colorView.backgroundColor = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
            
            segmentControl.tintColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2352941176, alpha: 1)
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            segmentControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1),
                .font: UIFont(name: "Avenir-MediumOblique", size: 15)
                                                   ?? .systemFont(ofSize: 15)], for: .normal)
            
        } else {
            mainImageView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            themeSwitch.thumbTintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            scrollContentView.backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
            
            sunImageView.tintColor = .systemYellow
            moonImageView.tintColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            nameLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            
            segmentControlLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            borderWidthSliderLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            borderColorSliderLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            cornerRadiusSliderLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            
            settingBorderWidthSlider.thumbTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            settingBorderWidthSlider.backgroundColor = .none
            settingBorderWidthSlider.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            
            settingCornerRadiusSlider.thumbTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            settingCornerRadiusSlider.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            settingCornerRadiusSlider.backgroundColor = .none
            
            colorView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
            
            segmentControl.tintColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8392156863, alpha: 1)
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            segmentControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1),
                .font: UIFont(name: "Avenir-MediumOblique", size: 15)
                                                   ?? .systemFont(ofSize: 15)], for: .normal)
        }
    }
    
    @objc private func changeImage(sender: UISegmentedControl) {
        mainImageView.image = UIImage(named: itemsImage[sender.selectedSegmentIndex])
    }
    
    @objc private func changeCornerRadius(sender: UISlider) {
        mainImageView.layer.cornerRadius = CGFloat(sender.value)
    }
    
    @objc private func changeBorderWidth(sender: UISlider) {
        mainImageView.layer.borderWidth = CGFloat(sender.value)
    }
    
    @objc private func changeRedColor(sender: UISlider) {
        redColor = CGFloat(sender.value)
        settingBorderRedColorSlider.tintColor = UIColor(red: redColor, green: 0, blue: 0, alpha: 1)
        mainImageView.layer.borderColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1).cgColor
    }
    
    @objc private func changeGreenColor(sender: UISlider) {
        greenColor = CGFloat(sender.value)
        settingBorderGreenColorSlider.tintColor = UIColor(red: 0, green: greenColor, blue: 0, alpha: 1)
        mainImageView.layer.borderColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1).cgColor
    }
    
    @objc private func changeBlueColor(sender: UISlider) {
        blueColor = CGFloat(sender.value)
        settingBorderBlueColorSlider.tintColor = UIColor(red: 0, green: 0, blue: blueColor, alpha: 1)
        mainImageView.layer.borderColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1).cgColor
    }
}

// MARK: setConstraints
extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            sunImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            sunImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 90),
            
            themeSwitch.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 90),
            themeSwitch.leadingAnchor.constraint(equalTo: sunImageView.trailingAnchor, constant: 5),
            
            moonImageView.leadingAnchor.constraint(equalTo: themeSwitch.trailingAnchor, constant: 5),
            moonImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 90),
            
            nameLabel.centerYAnchor.constraint(equalTo: moonImageView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            
            mainImageView.topAnchor.constraint(equalTo: themeSwitch.bottomAnchor, constant: 30),
            mainImageView.widthAnchor.constraint(equalToConstant: 0.9 * view.frame.width),
            mainImageView.heightAnchor.constraint(equalToConstant: 1.2 * view.frame.width),
            mainImageView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            segmentControlLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            segmentControlLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            segmentControlLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            
            segmentControl.topAnchor.constraint(equalTo: segmentControlLabel.bottomAnchor, constant: 10),
            segmentControl.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 30),
            segmentControl.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -30),
            
            cornerRadiusSliderLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            cornerRadiusSliderLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            cornerRadiusSliderLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            
            settingCornerRadiusSlider.topAnchor.constraint(equalTo: cornerRadiusSliderLabel.bottomAnchor, constant: 10),
            settingCornerRadiusSlider.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 30),
            settingCornerRadiusSlider.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -30),
            
            borderWidthSliderLabel.topAnchor.constraint(equalTo: settingCornerRadiusSlider.bottomAnchor, constant: 20),
            borderWidthSliderLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            borderWidthSliderLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            
            settingBorderWidthSlider.topAnchor.constraint(equalTo: borderWidthSliderLabel.bottomAnchor, constant: 10),
            settingBorderWidthSlider.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 30),
            settingBorderWidthSlider.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -30),
            
            borderColorSliderLabel.topAnchor.constraint(equalTo: settingBorderWidthSlider.bottomAnchor, constant: 20),
            borderColorSliderLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            borderColorSliderLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            
            colorView.topAnchor.constraint(equalTo: borderColorSliderLabel.bottomAnchor, constant: 10),
            colorView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20),
            colorView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            colorView.heightAnchor.constraint(equalToConstant: 120),
            
            colorSliderStack.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 10),
            colorSliderStack.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 10),
            colorSliderStack.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -10),
            colorSliderStack.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -10),
            
            colorView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -70),
        ])
    }
}
