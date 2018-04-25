//
//  Extension+TextField.swift
//  TestPod
//
//  Created by Sowattana on 4/24/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit

protocol UIControlObserver: AnyObject {
    associatedtype T
    func onValuedUpdated(value: T)
    func getIdentifier() -> String
    func onInitializeObserver() -> Void
}

extension UIControlObserver {
    var identifier: String {
        return getIdentifier()
    }
    
    var rz: Observer<T> {
        if let observer = FlyweightObserver.getObserver(with: identifier, type: T.self) {
            return observer
        } else{
            let rz = Observer<T>()
            rz.update = ({ [weak self] (value) in
                guard let `self` = self else { return }
                self.onValuedUpdated(value: value!)
            })
            FlyweightObserver.addObserver(with: self.identifier, observer: rz)
            onInitializeObserver()
            return rz
        }
    }

}

extension UITextField {

    var identifier: String {
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }

    public var rz: Observer<String> {
        if let observer = FlyweightObserver.getObserver(with: identifier, type: String.self) {
            return observer
        } else{
            let rz = Observer("")
            rz.update = ({ [weak self] (value) in
                guard let `self` = self else { return }
                self.text = value
            })
            addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
            FlyweightObserver.addObserver(with: identifier, observer: rz)
            return rz
        }
    }

    @objc func textChanged(sender: UITextField) {
        rz.update(value: text ?? "")
    }

}

//extension UITextField: UIControlObserver {
//    typealias T = String
//
//    func onValuedUpdated(value: String) {
//        self.text = value
//    }
//
//    func getIdentifier() -> String {
//        return String(UInt(bitPattern: ObjectIdentifier(self)))
//    }
//
//    func onInitializeObserver() {
//        addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
//    }
//
//    @objc func textChanged(sender: UITextField) {
//        rz.update(value: text ?? "")
//    }
//
//}

