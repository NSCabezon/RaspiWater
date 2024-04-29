import Foundation

protocol GPIORepositoryProtocol {
    func getValue(ofPin pin: Pin) -> GPIOValue
    func getAllPinValues() -> [PinValue]
    func set(pinValue: PinValue)
    func blink(pin: Pin, times: Int) throws
}
