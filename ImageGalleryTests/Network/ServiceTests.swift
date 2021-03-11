//
//  ServiceTests.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import XCTest
@testable import ImageGallery

class ServiceTests: XCTestCase {
    
    func testListServicePath() {
//        let pokemonsList = Service.
        XCTAssertEqual(pokemonsList.path, "pokemon?offset=5&limit=3")
    }
    
    func testCustomUrlPath() {
        let customUrl = Service.custom(url: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=200")
        XCTAssertEqual(customUrl.path, "")
    }
    
    func testPokemonsListHTTPMethod() {
        let pokemonsList = Service.pokemonsList(take: 3, skip: 5)
        XCTAssertEqual(pokemonsList.httpMethod, .get)
    }
    
    func testCustomUrlHTTPMethod() {
        let customUrl = Service.custom(url: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=200")
        XCTAssertEqual(customUrl.httpMethod, .get)
    }

    func testPokemonsListBaseUrl() {
        let pokemonsList = Service.pokemonsList(take: 3, skip: 5)
        XCTAssertEqual(pokemonsList.baseUrl?.absoluteString, "https://pokeapi.co/api/v2/")
    }
    
    func testCustomUrlBaseUrl() {
        let customUrl = Service.custom(url: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=200")
        XCTAssertEqual(customUrl.baseUrl?.absoluteString, "https://pokeapi.co/api/v2/pokemon?limit=100&offset=200")
    }
}
