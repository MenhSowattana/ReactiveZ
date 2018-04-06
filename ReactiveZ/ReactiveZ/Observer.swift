//
//  Observer.swift
//  MVVMTest
//
//  Created by Menh Sowattana on 2/16/18.
//  Copyright © 2018 Menh Sowattana. All rights reserved.
//

import UIKit

enum ObserveState {
    case Binded
    case Observed
    case None
}

class Observer<Element>: Observe {
    
    weak var observable: Observable?
    private var _value: Element?
    
    var state = ObserveState.None
    var map: Any?
    var update: ((_ value: Element?) ->  Void)?
    
    init(_ value: Element) {
        _value = value
    }
    
    func bind<T>(to variable : ObservableField<T>, map: ((_ value: T) -> Element)? = nil, mapBack: ((_ value: Element) -> T)? = nil){
        if state == .None {
            observable = variable
            self.map = map
            variable.setMapBack(mapBack: mapBack)
            variable.onSubscribed(observer: self)
            state = .Binded
        }else{
            fatalError("You cannot bind to multiple observable object")
        }
    }
    
    
    func observe<T>(observable: ObservableField<T>, map:  ((_ value: T) -> Element)? = nil, mapBack: ((_ value: Element) -> T)? = nil) {
        if state == .None {
            self.observable = observable
            self.map = map
            observable.setMapBack(mapBack: mapBack)
            observable.onSubscribed(observer: self)
            state = .Observed
        }else{
            fatalError("You cannot bind to multiple observable object")
        }
    }
    
    override func onObservedValueChanged<T>(value: T) {
        if let map = self.map as? (_ value: T) -> Element {
            _value = map(value)
        }else{
            _value = value as? Element
        }
        
        if let `update` = self.update {
            update(_value)
        }
    }
    
    func update(value: Element) {
        guard let `observable` = observable else { return }
        observable.setValue(value: value)
        
    }
    
    func get() -> Element {
        return _value!
    }
    
    deinit {
        print("Observer is deinitialized.")
        observable = nil
    }
}


