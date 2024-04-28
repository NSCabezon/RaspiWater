import Foundation

protocol GPIORepositoryProtocol: Sendable {
    func getValue(ofPin pin: Pin) -> GPIOValue
    func getAllPinValues() -> [PinValue]
    func set(pinValue: PinValue)
    func blink(pin: Pin, times: Int) throws
}
