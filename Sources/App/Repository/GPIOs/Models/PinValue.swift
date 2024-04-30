import Foundation
import Vapor

struct PinValue: Content, Codable {
    var pin: Pin
    var value: GPIOValue
}
