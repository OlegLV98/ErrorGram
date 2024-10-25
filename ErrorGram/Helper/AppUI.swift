//
//  AppUI.swift
//  HW11UIKit_LesnoyOleg
//
//  Created by Oleg Lesnoy on 19.05.2024.
//

import UIKit

class AppUI {
    static func createLabel(text: String, fontSize: CGFloat = 15) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        label.font = UIFont(name: "Avenir-MediumOblique", size: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createSlider(maximumValue: Float = 1, value: Float = 0, thumbTintColor: UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), target: Any?, action: Selector) -> UISlider {
        let slider = UISlider()
        slider.backgroundColor = .none
        slider.minimumValue = 0
        slider.maximumValue = maximumValue
        slider.thumbTintColor = thumbTintColor
        slider.value = value
        slider.addTarget(target, action: action, for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
    
    static func createImageView(image: String, tintColor: UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 31).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        imageView.image = UIImage(systemName: image)
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}
