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

public class Observer<Element>: Observe {
    
    weak var observable: Observable?
    private var _value: Element?
    
    var state = ObserveState.None
    var map: Any?
    public var update: ((_ value: Element?) ->  Void)?
    
    public init(_ value: Element) {
        _value = value
    }
    
    public override init() {
        
    }
    
    public func bind<T>(to variable : ObservableField<T>, map: ((_ value: T) -> Element)? = nil, mapBack: ((_ value: Element) -> T)? = nil){
        if state == .None {
            observable = variable
            self.map = map
            variable.setMapBack(mapBack: mapBack)
            variable.onSubscribed(observer: self)
            state = .Binded
        }else{
            fatalError("You cannot bind to multiple observable objects")
        }
    }
    
    
    public func observe<T>(observable: ObservableField<T>, map:  ((_ value: T) -> Void)? = nil) {
        if state == .None {
            self.observable = observable
            self.map = map
            observable.onSubscribed(observer: self)
            state = .Observed
        }else{
            fatalError("You cannot observe to multiple observable objects")
        }
    }
    
    override func onObservedValueChanged<T>(value: T) {
        if let map = self.map as? (_ value: T) -> Element {
            _value = map(value)
        } else if let map = self.map as? (_ value: T) -> Void {
            map(value)
        }
        else{
            _value = value as? Element
        }
        
        if let `update` = self.update {
            update(_value)
        }
    }
    
    public func update(value: Element) {
        guard let `observable` = observable else { return }
        observable.setValue(value: value)
        
    }
    
    public func get() -> Element {
        return _value!
    }
    
    deinit {
        print("Observer is deinitialized.")
        observable = nil
    }
}


