//
//  SearchComicsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/02.
//

import Foundation

class ComicsViewModel {
    
    var comics = [Comics]()
    var error: Error?
    
    private let comicRepository: ComicRepositoryType
    
    init(comicRepository: ComicRepositoryType) {
        self.comicRepository = comicRepository
    }
    
    func fetchComics(){
        comicRepository.fetchComics { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let comics):
                self.comics = comics.data.results
                for comic in self.comics {
                    print(comic.title)
                }
            case .failure(let error):
                print(self.error = error)
            }
             
        }
    }
}
