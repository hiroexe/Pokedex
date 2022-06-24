//
//  Size.swift
//  pokedex
//
//  Created by Ivo Junior Bettini on 22/06/22.
//

import Foundation

struct Pokemons : Codable{
    var sizes: [PokemonSize]
}

struct PokemonSize : Codable, Identifiable  {
    
    let id = UUID()
    var weight: Int
    var lenght: Int

}

class PokeApiInfo  {
    func getData(completion:@escaping ([PokemonSize]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=/(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemons.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.sizes)
            }
        }.resume()
    }
}
