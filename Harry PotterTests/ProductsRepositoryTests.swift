//
//  ProductsRepositoryTests.swift
//  Harry PotterTests
//
//  Created by Fady Yecob on 13/11/2021.
//

import XCTest
@testable import Harry_Potter

class ProductsRepositoryTests: XCTestCase {
    private var productsRepository: ProductsRepository!

    override func setUpWithError() throws {
        productsRepository = ProductsRepository()
    }

    override func tearDownWithError() throws {
        productsRepository = nil
    }
    
    func testProductWithoutAuthorAttributes() throws {
        let products = productsRepository.fetchProducts()
        let product = products[2]

        let expectedProduct = Product(
            title: "Harry Potter: Complete 8-Film Collection (Blu-ray Disc, 2011, 8-Disc Set)",
            author: nil,
            imageURL: try XCTUnwrap(URL(string: "http://i.ebayimg.com/00/$(KGrHqR,!igE6M5wILm(BOuWZc0bjg~~_1.JPG?set_id=89040003C1"))
        )
        
        XCTAssertEqual(product, expectedProduct)
    }
    
    func testProductWithoutAuthorAttribute() throws {
        let products = productsRepository.fetchProducts()
        let product = products[3]

        let expectedProduct = Product(
            title: "Harry Potter Years 1-7 by J. K. Rowling and Inc. Staff Scholastic (2007, Hardcover)",
            author: "J.K. Rowling",
            imageURL: try XCTUnwrap(URL(string: "http://i.ebayimg.com/00/$T2eC16F,!)kE9s4Z-Ue7BRb4ZE0oog~~_1.JPG?set_id=89040003C1"))
        )
        
        XCTAssertEqual(product, expectedProduct)
    }
}
