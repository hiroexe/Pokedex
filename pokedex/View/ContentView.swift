//
//  ContentView.swift
//  pokedex
//
//  Created by Ivo Junior Bettini on 21/06/22.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct ContentView: View {
    @State var pokemon = [PokemonInfo]()
    @State var searchText = ""

    @ObservedObject var database = SizeParserMini()
    
    var body: some View {

        NavigationView {
            
            List {
                ForEach(searchText == "" ? database.pokemons : database.pokemons.filter( {$0.name.contains(searchText.lowercased())} )) {
                    entry in
                    
                    HStack {
                        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int(entry.id)!).png"))
                            .padding(.trailing, 20)
                            .frame(width: 75, height: 75)
                        
                        NavigationLink("\(entry.name)".capitalized,
                                       destination: ContentView2(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int(entry.id)!).png")!,
                                                                 entry.name,
                                                                 entry.height,
                                                                 entry.weight)
                        )
                    }
                    
                }.listRowBackground(Color.mint .opacity(0.9))
                    
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = .red
        self.pokemon = database.pokemons
    }
}

struct ContentView2: View {
    var image: URL
    var name: String
    var weight: Int
    var height: Int
    
    var body: some View {
        ZStack{
            Image("5818315").resizable().aspectRatio(contentMode: .fit).frame(width: 1100, height: 1100, alignment: .center).opacity(0.7)
            VStack {
                Text(name)
                    .padding()
                AsyncImage(url: image)
                    .padding(.trailing, 20)
                    .frame(width: 75, height: 75)
                Text("Weight: \(weight)")
                    .padding()
                Text("Height: \(height)")
                    .padding()
            }
        
        }
    }
    
    init(_ image: URL, _ name: String, _ weight: Int, _ height: Int) {
        self.image = image
        self.name = name
        self.weight = weight
        self.height = height
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PokemonInfo: Identifiable {
    var id: String
    var name: String
    var weight: Int
    var height: Int
    var url: String
}

class SizeParserMini: ObservableObject{
    @Published var pokemons = [PokemonInfo]()
    
    init() {
        let urls: [URL] = (1...151).map({ URL(string: "https://pokeapi.co/api/v2/pokemon/\($0)")! })
        //print("Initialized PokemonParser with urls")
        for i in urls {
            URLCache.shared.removeAllCachedResponses()
            //print("Call: \(i)")
            AF.request(i).response{ response in
                if response.error != nil {
                    print("Error in call")
                }
                
                let json = try! JSON(data: response.data!)
                //print(json["id"])
                DispatchQueue.main.async {
                    self.pokemons.append(PokemonInfo(id: json["id"].stringValue,
                                                     name: json["name"].stringValue,
                                                     weight: Int(json["weight"].stringValue)!,
                                                     height: Int(json["height"].stringValue)!,
                                                     url: i.absoluteString))
                    self.pokemons = self.pokemons.sorted(by: { Int($0.id)! < Int($1.id)! } )
                }
            }
        }
    }
}
