//
//  Observe.swift
//  ReactiveZ
//
//  Created by Sowattana on 4/6/18.
//  Copyright © 2018 icoding. All rights reserved.
//

import UIKit

public class Observe {
    func onObservedValueChanged<T>(value: T) {
        preconditionFailure("This method must be overridden")
    }
}

