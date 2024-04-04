//
//  EventsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

class EventsViewModel {
    
    var events = [Events]()
    var error: Error?
    
    private let eventsRespository: EventsRepositoryType
    
    init(eventsRespository: EventsRepositoryType) {
        self.eventsRespository = eventsRespository
    }
    
    func fetchEvents(){
        eventsRespository.fetchEvents {[weak self] result in guard let self = self else {return}
            switch result {
            case .success(let events):
                self.events = events.data.results
                for event in self.events {
                    print(event)
                }
            case .failure(let error):
                print(self.error = error)
                }
            }
        }
    }
    
