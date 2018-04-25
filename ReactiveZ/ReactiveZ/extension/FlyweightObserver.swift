//
//  FlyweightObserver.swift
//  TestPod
//
//  Created by Sowattana on 4/24/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit

public class FlyweightObserver {
    private static var arrayDictionary: [String: Observe] = [:]
    
    static func getObserver<T>(with identifier: String,type: T.Type) -> Observer<T>? {
        if let obj = arrayDictionary[identifier] {
            return obj as? Observer<T>
        }
        return nil
    }
    
    static func addObserver<T>(with identifier: String,observer: Observer<T>) {
        guard arrayDictionary[identifier] != nil else {
            arrayDictionary.updateValue(observer, forKey: identifier)
            return
        }
    }
    
    static func removeObject(with identifier: String) {
        if arrayDictionary[identifier] != nil {
            arrayDictionary.removeValue(forKey: identifier)
        }
    }
    
    public static func removeAll() {
        arrayDictionary.removeAll()
    }
    
}
