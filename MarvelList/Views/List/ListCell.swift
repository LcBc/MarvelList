//
//  ListCell.swift
//  MarvelList
//
//  Created by Luis Barrios on 25/1/22.
//

import SwiftUI

struct ListCell: View {
    @State var character:MarvelCharacter
    var body: some View {
        NavigationLink(destination: DetailView(character: character)) {
            VStack {
                if let url = character.thumbnail.fullPath {
                    
                    AsyncImage(
                        url: url,
                        placeholder: { Text("Loading ...") }
                    ).frame(width: 135, height: 135, alignment: .top).aspectRatio(contentMode: .fit)
                    
                }else{
                    Image(uiImage: #imageLiteral(resourceName: "not-found"))
                        .resizable().frame(width: 135, height: 50, alignment: .top).aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(character.name)")
                            .font(.caption)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                        
                        
                    }.frame(width: 100, height: 20, alignment: .top)
                    
                    
                }
                
            }.cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
                ).frame(width: 135, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        let char = MarvelCharacter(id: 0, name: "test", description: "description", thumbnail: Thumbnail(path: "path", type: ".json"))
        ListCell(character: char )
    }
}
