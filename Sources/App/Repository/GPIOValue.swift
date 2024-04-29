import Foundation

enum GPIOValue: Int, Codable {
    case on = 1
    case off = 0
    case unknown = 1000
}
