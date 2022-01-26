//
//  ListViewModel.swift
//  MarvelList
//
//  Created by Luis Barrios on 25/1/22.
//

import Foundation
import Combine
import UIKit
class ListViewModel:ObservableObject {
    
    var session = URLSession.shared
    private var page = 0
    var currentPage:Int { page}
    private var requestLimit = 20
    @Published private(set) var characters = [MarvelCharacter]()
    @Published private(set) var isLoading = true
    private var maxPage = 100
    var listIsFull = false
    var cancellables = [AnyCancellable]()
        
    func fetchCharacters(){
        let publisher = session.publisher(for: .CharacterList(offset: page ,auth: AuthenticationModel()), using: ())
        if  page < maxPage {
           isLoading = true
            var cancellable: AnyCancellable
            cancellable = publisher.receive(on: RunLoop.main).sink {
               print($0)
                self.isLoading = false
                
            } receiveValue: { [self] in                
                characters.append(contentsOf: $0.results)
                page += requestLimit
                maxPage = $0.total
                if $0.count < self.requestLimit{
                    self.listIsFull = true
                }
            }
            cancellable.store(in: &cancellables)
        }else{
            characters = characters
            
        }
    }

}
