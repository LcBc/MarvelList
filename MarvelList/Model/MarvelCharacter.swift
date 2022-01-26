//
//  ListResponse.swift
//  MarvelList
//
//  Created by Luis Barrios on 22/1/22.
//

import Foundation



struct MarvelCharacter:Codable, Equatable{
   
    var id:Int
    var name:String
    var description:String
    var thumbnail:Thumbnail
   
    public init(id:Int,name:String,description:String,thumbnail:Thumbnail){
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        
    }
    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        lhs.id == rhs.id
    }
    
}

struct Resource:Codable{
    
    var type:String
    var url:String
    
}



struct Thumbnail:Codable{
    var path:String
    var type:String
    var fullPath:URL? {URL(string:"\(path).\(type)") }
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case type = "extension"
    }
    
    init(path:String,type:String){
        self.path = path
        self.type = type
    }
}




struct CharacterResponseData:Codable, Equatable{
   
    var offset:Int
    var limit:Int
    var total:Int
    var count:Int
    var results: [MarvelCharacter]
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results

    }
    
    static func == (lhs: CharacterResponseData, rhs: CharacterResponseData) -> Bool {
        lhs.results == lhs.results
    }
    
    
}


struct NetworkResponse<Wrapped: Codable>:Codable,Equatable {
    static func == (lhs: NetworkResponse<Wrapped>, rhs: NetworkResponse<Wrapped>) -> Bool {
        lhs.etag == rhs.etag
    }
    
    var code: Int
    var status: String
    var copyright:String
    var attributionText:String
    var etag:String
    var data: Wrapped
    
    
    

}






