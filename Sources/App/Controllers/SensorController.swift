import Vapor

struct SensorController: RouteCollection {
    private let sensorsRepository: SensorsRepositoryProtocol
    
    init(sensorsRepository: SensorsRepositoryProtocol) {
        self.sensorsRepository = sensorsRepository
    }
    
    func boot(routes: RoutesBuilder) throws {
        let sensorsRoutes = routes.grouped("sensors")

        sensorsRoutes.get(use: { try await self.getSensors(req: $0) })
    }
    
    func getSensors(req: Request) async throws -> [Terrace] {
        sensorsRepository.getSensorsStatus()
    }
}
