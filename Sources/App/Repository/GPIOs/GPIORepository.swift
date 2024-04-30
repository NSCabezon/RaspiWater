import Foundation
import SwiftyGPIO

struct GPIORepository: GPIORepositoryProtocol, Sendable {
    func getAllPinValues() -> [PinValue] {
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi4)
        
        let valueToReturn = gpios.compactMap { (key: GPIOName, value: GPIO) -> PinValue? in
            guard let gpioValue = GPIOValue(rawValue: value.value),
                  let pin = Pin(rawValue: key.rawValue) else { return nil }
            return PinValue(pin: pin, value: gpioValue)
        }
        return valueToReturn
    }
    
    func getValue(ofPin pin: Pin) -> GPIOValue {
        guard let swiftPin = GPIOName(rawValue: pin.rawValue) else {
            return .unknown
        }
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi4)
        guard let gp = gpios[swiftPin],
              let value = GPIOValue(rawValue: gp.value) else {
            return .unknown
        }
        return value
    }
    
    func set(pinValue: PinValue) {
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi4)
        guard let pinName = GPIOName(rawValue: pinValue.pin.rawValue),
        let gp = gpios[pinName] else {
            return
        }
        gp.value = pinValue.value.rawValue
    }
    
    func blink(pin: Pin, times: Int) throws {
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi4)
        guard let name = GPIOName(rawValue: pin.rawValue),
              let gp = gpios[name] else {
            throw RepositoryError.unableToLocateGPIO
        }
        gp.direction = .OUT
        
        for _ in 0..<times {
            gp.value = (gp.value == 0) ? 1 : 0
            sleep(1)
        }
    }
}
