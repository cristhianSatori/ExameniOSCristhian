//
//  Protocols.swift
//  ExameniOS
//
//  Created by Satori Tech 11 on 13/06/22.
//

import UIKit

protocol ReusableCell {
    static var identifier: String { get }
    static var nibName: UINib { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nibName: UINib {
        return UINib(nibName: identifier, bundle: .main)
    }
}
