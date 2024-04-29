import Foundation

final class GPIORepositoryMock: GPIORepositoryProtocol {
    
    private var values: [PinValue] = [
        .init(pin: .P1, value: .off),
        .init(pin: .P3, value: .on),
        .init(pin: .P22, value: .on)
    ]
    
    func getAllPinValues() -> [PinValue] {
        values
    }
    
    func getValue(ofPin pin: Pin) -> GPIOValue {
        guard let result = values.first(where: { $0.pin == pin }) else {
            return GPIOValue.off
        }
        return result.value
    }
    
    func set(pinValue: PinValue) {
        guard let index = values.firstIndex(where: { $0.pin == pinValue.pin }) else {
            return
        }
        values[index] = pinValue
    }
    
    func blink(pin: Pin, times: Int) throws {
        if !times.isMultiple(of: 2) {
            guard let index = values.firstIndex(where: { $0.pin == pin }) else {
                return
            }
            values[index].value = values[index].value == .on ? .off : .on
        }
    }
}
