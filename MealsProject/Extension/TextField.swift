//
//  TextField.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

extension UITextField
{
    internal func addBottomBorder() {
        let height: CGFloat = 1.5
        let color: UIColor = ConstantsCorol.mainGreyColor
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(borderView)
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height)
            ]
        )
    }
}
