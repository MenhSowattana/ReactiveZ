//
//  RzTextField.swift
//  ReactiveZ
//
//  Created by Sowattana on 4/6/18.
//  Copyright © 2018 icoding. All rights reserved.
//

import UIKit

//public class RzTextField: UITextField {
//    public var rz: Observer<String>!
//
//    fileprivate func initialize() {
//        if rz == nil {
//            rz = Observer("")
//            rz.update = { [weak self] (value) in
//                guard let `self` = self else { return }
//                self.text = value
//            }
//            addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initialize()
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initialize()
//    }
//
//    @objc func textChanged(sender: UITextField) {
//        rz.update(value: text ?? "")
//    }
//
//    deinit {
//        rz = nil
//    }
//}

