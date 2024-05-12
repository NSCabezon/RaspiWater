import Fluent
import Vapor

final class Sensor: Model, Content, Sendable {
    static let schema = "sensor"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Children(for: \.$sensor)
    var readings: [SensorReading]

    init() { }

    init(
        id: UUID? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
