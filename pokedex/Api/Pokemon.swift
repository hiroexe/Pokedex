//
//  Pokemon.swift
//  pokedex
//
//  Created by Ivo Junior Bettini on 21/06/22.
//
//https://pokeapi.co/api/v2/pokemon?limit=151

/*
import Foundation

struct Pokemon : Codable{
    var results: [PokemonEntry]
}

struct PokemonEntry : Codable, Identifiable  {
    
    var id: Int
    var name: String
    var url: String

}

class PokeApi  {
    func getData(completion:@escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let pokemonList = try JSONDecoder().decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(pokemonList.results)
                }
            }
            catch {
                print(error)
            }
            /*
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
            */
        }.resume()
    }
}
*/
