import Foundation
import Combine

enum RostelecomAutoAPI {
    static let agent = Agent()
    static let base = URL(string: "http://63b232058096.ngrok.io")!
}

extension RostelecomAutoAPI {
    static func parkings(longitude: String, latitude: String) -> AnyPublisher<[Parking], Error> {
        let request = URLRequest(url: URL(string: "http://63b232058096.ngrok.io/geocontroller/coords?long=\(longitude)&lat=\(latitude)&max_radius=400")!)
        print(request.url)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

struct Parking: Codable, Identifiable {
    let id = UUID().uuidString
    let long: Double
    let lat: Double
    let free_places: Int
}
