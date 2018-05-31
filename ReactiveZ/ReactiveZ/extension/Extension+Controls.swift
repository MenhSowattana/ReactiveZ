//
//  Extension+TextField.swift
//  TestPod
//
//  Created by Sowattana on 4/24/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit.UIImage
import UIKit.UITextField
import UIKit.UIImageView
import UIKit.UIButton
import UIKit.UILabel

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
    
    public var rz: Observer<T> {
        if let observer = FlyweightObserver.getObserver(with: identifier, type: T.self) {
            return observer
        } else{
            let rz = Observer<T>()
            rz.controlIdentifier = identifier
            rz.update = ({ [weak self] (value) in
                guard let `self` = self else { return }
                self.onValuedUpdated(value: value!)
            })
            FlyweightObserver.addObserver(with: self.identifier, observer: rz)
            onInitializeObserver()
            return rz
        }
    }
    
    func onInitializeObserver() -> Void {}
    
}

extension UITextField: UIControlObserver {
    
    typealias T = String
    
    func onValuedUpdated(value: String) {
        self.text = value
    }
    
    func getIdentifier() -> String {
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }
    
    func onInitializeObserver() {
        addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
    }
    
    public func setText(_ str: String) {
        text = str
        rz.update(value: text ?? "")
    }
    
    @objc func textChanged(sender: UITextField) {
        rz.update(value: text ?? "")
    }
    
}

extension UILabel: UIControlObserver {
    
    typealias T = String
    
    func onValuedUpdated(value: String) {
        self.text = value
    }
    
    func getIdentifier() -> String {
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }
    
}

extension UIImageView: UIControlObserver {
    
    typealias T = UIImage
    
    func onValuedUpdated(value: UIImage) {
        self.image = value
    }
    
    func getIdentifier() -> String {
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }
    
}

extension UIButton: UIControlObserver {
    
    typealias T = String
    
    func onValuedUpdated(value: String) {
        self.setTitle(value, for: .normal)
    }
    
    func getIdentifier() -> String {
        return String(UInt(bitPattern: ObjectIdentifier(self)))
    }
    
}

