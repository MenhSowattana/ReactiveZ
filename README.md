# ReactiveZ
Lightweight Reactive programming library in swift. It provides bi-directional binding for UIControls.

# Installation
ReactiveZ is available through CocoaPods. To install it, simply add the following line to your Podfile:

``` 
pod 'ReactiveZ'
```

# Usage
## ObservableField
it makes variable with any types to be observable.  

```swift
let name: ObservableField<String> = ObservableField("")
let age: ObservableField<Int> = ObservableField(0)
let money: ObservableField<Double> = ObservableField(0.0)
let contacts: ObservableField<[String]> = ObservableField([])
```

You can also write in short as :

```swift
let name = ObservableField("")
```

it also support with custom object and optional wrapping.

```swift
let student: ObservableField<Student?> = ObservableField(nil)
```

in order to get value from ObservableField, we use:

```swift
print(name.get())
```

in order to set value into ObservableField, we use:

```swift
name.set(value: "Example")
```

## Observer
It is used to observe the Observable Type.

```swift
let nameObserver = Observer<String>()
let ageObserver = Observer<Int>()
```
## Binding & Observing

Observing is one-directional binding which observer can only observe the value changing of a observable type.

```swift
nameObserver.observe(observable: name)
```

Binding is bi-directional binding which observer can observe and change the value of a observable type.

```swift
nameObserver.bind(to: name)
```

You can annonymously observe the ObservableField object without creating observer.

```swift
name.observe { (value) in
    print(value)
}
```
> **Notice** : One ObservableField can be observed by many observers. One Observer can only observe or bind with only one ObservableField.

### Update & Get Value

To update value to:

```swift
nameObserver.update(value: "Tata")
```
To get value:

```swift
print(nameObserver.get())
```

## Binding with UIControls

When use with UIControls, we use `rz` property to simplify binding. Currently, we can only support controls as below:

| UIControls        | Binding Property           |
| ----------------- |:--------------------------:|
| UITextField       | text                       | 
| UILabel           | text                       | 
| UIImageView       | image                      | 
| UIButton          | title                      | 

**Usage** 

```swift
let disposal = Disposal()
textField.rz.bind(to: name, disPosal: disposal) // name is ObservableField
```
> **Notice** : When you bind with UIControl, `Disposal` is needed to prevent memory leak.

You have to call dispose when you stop using the observer.

```swift
deinit {
   disposal.dispose()
}
```

## Map Value

Map value is needed when you bind Observer and ObservableField with different type.

```swift
let age: ObservableField<Int> = ObservableField(0)
let ageMessageObserver = Observer<String>()
        
ageMessageObserver.bind(to: age, map: { (value) -> String in
    return "My age is \(value)"
}, mapBack: { (value) -> Int in
    return value == "reset" ? 0 : 20
})
```







