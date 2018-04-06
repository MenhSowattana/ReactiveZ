//
//  Observable.swift
//  MVVMTest
//
//  Created by Menh Sowattana on 2/9/18.
//  Copyright © 2018 Menh Sowattana. All rights reserved.
//

import UIKit

public class Observable {    
    
    func setValue<T>(value : T) {
        preconditionFailure("This method must be overridden")
    }
    
    func onSubscribed<T>(observer: Observer<T>){
        preconditionFailure("This method must be overridden")
    }
    
}
