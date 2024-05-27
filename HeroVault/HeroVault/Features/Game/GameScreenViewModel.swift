//
//  GameScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

class GameScreenViewModel {
    
    // MARK: Variables
    var error: Error?
    private var games = [Game]()
    private var currentGameDescription = ""
    private var currentGameThumbnails = [String]()
    private let gameScreenRepository: GameScreenRepositoryType
    private weak var delegate: ViewModelProtocol?
    
    init(gameScreenRepository: GameScreenRepositoryType, delegate: ViewModelProtocol) {
        self.gameScreenRepository = gameScreenRepository
        self.delegate = delegate
    }
    
    // MARK: Functions
    
    func fetchEvents() {
        delegate?.startLoadingIndicator()
        gameScreenRepository.fetchGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let events):
                self.games = events.data.results
                delegate?.reloadView()
            case .failure(let error):
                print("error: \(error)")
            }
            delegate?.stopLoadingIndicator()
        }
    }
    
    var generateDescription: String {
        currentGameDescription = games.randomElement()?.overview ?? ""
        return currentGameDescription
    }
    
    var testArray = [String]()
    var correctThumbnail: String?
    
    var generateImage: String {
       // var test = ""
       // guard let correctGame = games.first(where: { $0.overview == currentGameDescription })?.thumbnail else { return "" }

        //correctThumbnail = "\(correctGame)/portrait_incredible.jpg".convertToHttps()
         //   test = "\(correctGame)/portrait_incredible.jpg".convertToHttps()
           // testArray.append(test)
        
        //return test
        
        var result = generateRandomImages()
        if result.isEmpty {
            return ""
        } else {
           testArrayThree = result
            testArrayThree.shuffle()
                       counter += 1
            return result[counter]
        }
       
    }
    
    
    var testArrayThree = [String]()
    func generateRandomImages() -> [String] {
        
        guard let correctGameThumbnail = games.first(where: { $0.overview == currentGameDescription })?.thumbnail else { return [] }
        
        correctThumbnail = "\(correctGameThumbnail)/portrait_incredible.jpg".convertToHttps()
        
        let incorrectThumbnails = games.filter { $0.overview != currentGameDescription }.map { "\($0.thumbnail)/portrait_incredible.jpg".convertToHttps() }
        
        let randomIncorrectThumbnails = Array(incorrectThumbnails.shuffled().prefix(3))
        
        guard let correctThumbnail else { return [] }
        
        if testArrayThree.count > 4 {
            testArrayThree = []
        } else {
            testArrayThree.append(correctThumbnail)
            testArrayThree.append(contentsOf: randomIncorrectThumbnails)
        }
        //testArrayThree.shuffled()
        
        return testArrayThree
        
    }
    
    var counter = 0
//    var generateImage: String {
//        if isRun == false {
//            generateRandomImages()
//            
//            let image = currentGameThumbnails[counter]
//            counter += 1
//            //        if counter == 4 {
//            //            currentGameThumbnails = []
//            //        }
//            return "\(image)/portrait_incredible.jpg".convertToHttps()
//        }
//        return ""
//    }
    
//    func checkAnswer(atIndex: Int) -> Bool {
//        let correctGame = games.first { $0.overview == currentGameDescription }
//        return correctGame?.thumbnail == currentGameThumbnails[atIndex] ? true : false
//    }
    
    func checkAnswer(atIndex: Int) -> Bool {
        //let correctGame = games.first { $0.overview == currentGameDescription }
        guard let correctThumbnail else { return false }
        return correctThumbnail == testArrayThree[atIndex] ? true : false
//        return correctGameOne?.thumbnail == currentGameThumbnails[atIndex] ? true : false
    }
    
    func playGameAgain() {
        delegate?.reloadView()
      }
}
