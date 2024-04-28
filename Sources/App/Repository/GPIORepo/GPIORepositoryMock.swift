import Foundation

final class GPIORepositoryMock: GPIORepositoryProtocol, Sendable {
    
    private var values = [String: Int]()
    
    func getAllPinValues() -> [PinValue] {
        values.compactMap { (key: String, value: Int) in
            guard let pin = Pin(rawValue: key),
                  let gpio = GPIOValue(rawValue: value) else {
                return nil
            }
            return PinValue(pin: pin, value: gpio)
        }
    }
    
    func getValue(ofPin pin: Pin) -> GPIOValue {
        guard let value = values[pin.rawValue],
        let valueToReturn = GPIOValue(rawValue: value) else {
            let randomValue = [GPIOValue.off, GPIOValue.on].randomElement()!
            values[pin.rawValue] = randomValue.rawValue
            return randomValue
        }
        return valueToReturn
    }
    
    func set(pinValue: PinValue) {
        values[pinValue.pin.rawValue] = pinValue.value.rawValue
    }
    
    func blink(pin: Pin, times: Int) throws {
        if !times.isMultiple(of: 2) {
            values[pin.rawValue] = values[pin.rawValue] == 1 ? 0 : 1
        }
    }
}
