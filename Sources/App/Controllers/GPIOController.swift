import SwiftyGPIO
import Vapor

struct GPIOController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let gpioRoutes = routes.grouped("gopio")

        gpioRoutes.get(use: { try await self.index(req: $0) })
        gpioRoutes.post(use: { try await self.blinkLed(req: $0) })
    }
    
    func index(req: Request) async throws -> [[String: Int]] {
#if os(OSX)
        return [["P12": 2]]
#else
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
        var result = [[String: Int]]()
        gpios.forEach { (key: GPIOName, value: GPIO) in
            result.append([key.rawValue: value.value])
        }
        return result
#endif
    }

    func blinkLed(req: Request) async throws -> HTTPStatus {
        let gpioRequest = try req.content.decode(GPIOBlinkRequest.self)
#if os(OSX)
        return .ok
#else
        let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
        guard let name = GPIOName(rawValue: gpioRequest.ledName.rawValue),
              let gp = gpios[name] else {
            throw Abort(.badRequest)
        }
        gp.direction = .OUT
        
        for _ in 0..<gpioRequest.timesToBlink {
            gp.value = (gp.value == 0) ? 1 : 0
            usleep(150*1000)
        }
        
        return .ok
#endif
    }
}
