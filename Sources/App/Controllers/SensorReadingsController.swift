import Fluent
import Vapor

struct SensorReadingsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let sensorValues = routes.grouped("sensorreadings")

        sensorValues.get(use: { try await self.index(req: $0) })
        sensorValues.group(":sensorReadingID") { todo in
            todo.delete(use: { try await self.delete(req: $0) })
        }
    }
    
    func index(req: Request) async throws -> [SensorReading] {
        try await SensorReading.query(on: req.db).all()
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let sensorReading = try await SensorReading.find(req.parameters.get("sensorReadingID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await sensorReading.delete(on: req.db)
        return .noContent
    }
}
