import Fluent

struct CreateSensorReading: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(SensorReading.schema)
            .id()
            .field("sensor_id", .uuid, .required, .references("sensor", "id", onDelete: .cascade))
            .field("value", .float, .required)
            .field("timestamp", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(SensorReading.schema).delete()
    }
}
