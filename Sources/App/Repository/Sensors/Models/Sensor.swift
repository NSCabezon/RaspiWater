import Foundation
import Vapor

struct Sensor: Content {
    let name: String
    let value: Float
}
