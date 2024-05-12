import Vapor

struct SensorsController: RouteCollection, Sendable {
    func boot(routes: RoutesBuilder) throws {
        let sensorsRoutes = routes.grouped("sensors")

        sensorsRoutes.get(use: { try await self.getSensors(req: $0) })
        sensorsRoutes.post(use: { try await self.create(req: $0) })
        sensorsRoutes.group(":sensorID") { sensor in
            sensor.delete(use: { try await self.delete(req: $0) })
        }
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
    
    func changeName(req: Request) async throws -> HTTPStatus {
        guard let sensor = try await Sensor.find(req.parameters.get("sensorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let changeNameReq = try req.content.decode(ChangeSensorNameRequest.self)
        sensor.name = changeNameReq.newName
        try await sensor.save(on: req.db)
        return .ok
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let sensor = try await Sensor.find(req.parameters.get("sensorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await sensor.delete(on: req.db)
        return .noContent
    }
}
