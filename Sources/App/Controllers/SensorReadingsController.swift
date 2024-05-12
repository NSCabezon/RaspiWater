import Fluent
import Vapor

struct SensorReadingsController: RouteCollection {
    private let sensorsRepository: SensorsRepositoryProtocol
    
    init(sensorsRepository: SensorsRepositoryProtocol) {
        self.sensorsRepository = sensorsRepository
    }
    
    func boot(routes: RoutesBuilder) throws {
        let sensorValues = routes.grouped("sensorreadings")

        sensorValues.get(use: { try await self.getAll(req: $0) })
        
        sensorValues.group(":sensorID") { sensorReading in
            sensorReading.get(use: { try await self.getValuesFromOneSensor(req: $0) })
            sensorReading.delete(use: { try await self.delete(req: $0) })
        }
        
        let sensorIndex = sensorValues.grouped("index")
        sensorIndex.group(":index") { idx in
            idx.get(use: { try await self.getSingleReading(req: $0) })
        }
    }
    
    func getSingleReading(req: Request) async throws -> SingleReading {
        guard let index = req.parameters.get("index", as: Int.self) else {
            throw Abort(.badRequest)
        }
        let value = sensorsRepository.getSensor(sensorIndex: index)
        return SingleReading(value: value)
    }
    
    func getAll(req: Request) async throws -> [SensorReadingDTO] {
        let readings = try await SensorReading.query(on: req.db).with(\.$sensor).all()
        return readings.map { $0.toReadingDTO(withSensorId: true) }
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
