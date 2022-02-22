//
//  CustomBinding.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 19/02/2022.
//

import Foundation
import SwiftUI
final class CustomBinding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
