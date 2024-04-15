//
//  SearchComicsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/02.
//

import UIKit

class SearchComicsViewController: UIViewController {
    
    private var comicsViewModel = ComicsViewModel(comicRepository: ComicRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsViewModel.fetchComics()
    }
}
