import Vapor

struct GPIOController: RouteCollection {
    private let gpioRepository: GPIORepositoryProtocol
    
    init(gpioRepository: GPIORepositoryProtocol) {
        self.gpioRepository = gpioRepository
    }
    
    func boot(routes: RoutesBuilder) throws {
        let gpioRoutes = routes.grouped("gopios")

        gpioRoutes.get(use: { try await self.index(req: $0) })
        gpioRoutes.post(use: { try await self.blinkLed(req: $0) })
    }
    
    func index(req: Request) async throws -> [PinValue] {
        gpioRepository.getAllPinValues()
    }

    func blinkLed(req: Request) async throws -> HTTPStatus {
        let gpioRequest = try req.content.decode(GPIOBlinkRequest.self)
        do {
            try gpioRepository.blink(pin: gpioRequest.ledName, times: gpioRequest.timesToBlink)
            return .ok
        } catch {
            throw Abort(.badRequest)
        }
    }
}
