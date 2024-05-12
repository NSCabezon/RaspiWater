import Foundation

protocol SensorsRepositoryProtocol: Sendable {
    func getSensorsStatus() -> [Terrace]
}
