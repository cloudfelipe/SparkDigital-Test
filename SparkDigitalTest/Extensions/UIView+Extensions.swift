//
//  UIView+Extensions.swift
//  SparkDigitalTest
//
//  Created by Felipe Correa on 9/08/21.
//

import UIKit

extension UIView {
    public func addToParent(_ parent: UIView) {
        parent.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    }
}
