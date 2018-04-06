//
//  NSPointerArrayExtension.swift
//  ReactiveZ
//
//  Created by Sowattana on 4/6/18.
//  Copyright © 2018 icoding. All rights reserved.
//

//
//  UITextField+Binding.swift
//  MVVMTest
//
//  Created by Menh Sowattana on 1/29/18.
//  Copyright © 2018 Menh Sowattana. All rights reserved.
//


extension NSPointerArray {
    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else { return }
        
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }
    
    func insertObject(_ object: AnyObject?, at index: Int) {
        guard index < count, let strongObject = object else { return }
        
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        insertPointer(pointer, at: index)
    }
    
    func replaceObject(at index: Int, withObject object: AnyObject?) {
        guard index < count, let strongObject = object else { return }
        
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        replacePointer(at: index, withPointer: pointer)
    }
    
    func object(at index: Int) -> Observe? {
        guard index < count, let pointer = self.pointer(at: index) else { return nil }
        return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue() as? Observe
    }
    
    func removeObject(at index: Int) {
        guard index < count else { return }
        removePointer(at: index)
    }
}



