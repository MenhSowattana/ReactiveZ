//
//  ObservableField.swift
//  MVVMTest
//
//  Created by Menh Sowattana on 2/8/18.
//  Copyright © 2018 Menh Sowattana. All rights reserved.
//

import UIKit

public class ObservableField<Element>: Observable{
    
    private var rx_value : Element!
    var observers : NSPointerArray?
    private var mapBack: Any?
    
    public init(_ value : Element) {
        rx_value = value
        observers = NSPointerArray.weakObjects()
    }
    
    override public func onSubscribed<T>(observer: Observer<T>) {
        observers?.addObject(observer)
        notifyObservers(rx_value)
    }
    
    override public func setValue<T>(value: T) {
        if let mapBack = self.mapBack as? (_ value: T) -> Element {
            rx_value = mapBack(value)
        }else{
            rx_value = value as? Element
        }
        notifyObservers(rx_value)
    }
    
    func setMapBack<T>( mapBack: ((_ value: T) -> Element)?){
        self.mapBack = mapBack
    }
    
    func onValueChanged(map: (_ value: Element) -> Void) {
        map(rx_value)
    }
    
    public func set(value : Element){
        rx_value = value
        notifyObservers(value)
    }
    
    func notifyObservers(_ value: Element) {
        for i in 0 ..< ((observers?.count) ?? 0)  {
            autoreleasepool {
                observers?.object(at: i)?.onObservedValueChanged(value: value)
            }
        }
    }
    
    public func get() -> Element {
        return rx_value
    }
    
    deinit {
        self.observers = nil
        print("ObservableField is deinitialized")
    }
}

