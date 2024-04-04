//
//  EventsRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

typealias EventsResult = Result<EventsResponse, NetworkingError>

protocol EventsRepositoryType {
    func fetchEvents(completion: @escaping (EventsResult) -> Void)
}

class EventsRepository: EventsRepositoryType {
    
    private let apiHandler = APIHandler()
    
    func fetchEvents(completion: @escaping (EventsResult) -> Void) {
        apiHandler.request(path:Constants.EndPoints.marvelStoryDescriptions, networkType: NetworkingRequestType.GET, model: EventsResponse.self) { result in completion(result)}
    }
}

// MARK: Events Response Model
struct EventsResponse: Codable {
    let data: EventsData
}

struct EventsData: Codable {
    let results: [Events]
}

struct Events: Codable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: EventsPictures
}

struct EventsPictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
