import Vapor

struct SensorController: RouteCollection, Sendable {
    func boot(routes: RoutesBuilder) throws {
        let sensorsRoutes = routes.grouped("sensor")

        sensorsRoutes.get(use: { try await self.getSensors(req: $0) })
        sensorsRoutes.post(use: { try await self.create(req: $0) })
    }
    
    func getSensors(req: Request) async throws -> [Sensor] {
        try await Sensor.query(on: req.db)
            .all()
    }

    func create(req: Request) async throws -> HTTPStatus {
        let sensors = try req.content.decode([Sensor].self)
        
        try await sensors.create(on: req.db)
        return .created
    }
}
