import Foundation

enum GPIOValue: Int {
    case on = 1
    case off = 0
    case unknown = 1000
}

struct PinValue {
    let pin: Pin
    let value: GPIOValue
}
