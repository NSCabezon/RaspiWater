import Foundation
import Vapor

struct SensorDTO: Content {
    let sensorId: UUID
    let value: Float
}
