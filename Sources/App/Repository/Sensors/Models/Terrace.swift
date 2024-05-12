import Foundation
import Vapor

struct Terrace: Content {
    let name: String
    let sensors: [SensorDTO]
}
