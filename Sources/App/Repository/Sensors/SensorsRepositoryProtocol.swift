import Foundation

protocol SensorsRepositoryProtocol: Sendable {
    func getSensor(sensorIndex: Int) -> Float
    func getSensorsStatus() -> [Terrace]
}
