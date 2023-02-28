//
//  DetailRecipe.swift
//  galleyRecipe
//
//  Created by garpun on 28.01.2023.
//

import Foundation

struct DetailRecipe: Decodable {
    let id: Int
    let title: String
    let extendedIngredients: [Ingredients]
    let readyInMinutes: Int
    let servings: Int
    let analyzedInstructions: [Instruction]
}

struct Ingredients: Decodable {
    let originalName: String
    let amount: Double
    let measures: Measures
}

struct Measures: Decodable {
    let metric: Metric
}

struct Metric: Decodable {
    let amount: Double
    let unitShort: String
}

struct Instruction: Decodable {
    let steps: [InstructionSteps]
}

struct InstructionSteps: Decodable {
    let number: Int
    let step: String
}
