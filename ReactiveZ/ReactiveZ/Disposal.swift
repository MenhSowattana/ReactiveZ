//
//  Disposal.swift
//  TestPod
//
//  Created by Sowattana on 4/24/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit

public class Disposal {
    private var identifiers: [String] = []
    public func add(identifier: String) {
        if !identifiers.contains(identifier) {
            identifiers.append(identifier)
        }
    }
    
    public func dispose() {
        identifiers.forEach { (identifier) in
            FlyweightObserver.removeObject(with: identifier)
        }
    }
}
