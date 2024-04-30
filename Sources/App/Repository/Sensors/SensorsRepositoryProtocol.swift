import Foundation

protocol SensorsRepositoryProtocol {
    func getSensorsStatus() -> [Terrace]
}
