import Fluent
import Vapor

struct SensorReadingsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let sensorValues = routes.grouped("sensorreadings")

        sensorValues.get(use: { try await self.getAll(req: $0) })
        sensorValues.group(":sensorID") { sensorReading in
            sensorReading.get(use: { try await self.getValuesFromOneSensor(req: $0) })
            sensorReading.delete(use: { try await self.delete(req: $0) })
        }
    }
    
    func getAll(req: Request) async throws -> [SensorReading] {
        try await SensorReading.query(on: req.db).all()
    }
    
    func getValuesFromOneSensor(req: Request) async throws -> [SensorReadingDTO] {
        guard let sensor = try await Sensor.find(req.parameters.get("sensorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let readings = try await sensor.$readings.get(on: req.db)
        return readings.map { $0.toReadingDTO() }
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let sensorReading = try await SensorReading.find(req.parameters.get("sensorID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await sensorReading.delete(on: req.db)
        return .noContent
    }
}
