//
//  EventsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import UIKit

class EventsViewController: UIViewController {
    
    private var eventsViewModel = EventsViewModel(eventsRespository: EventsRepository())

    override func viewDidLoad() {
        super.viewDidLoad()
        eventsViewModel.fetchEvents()
    }
}
