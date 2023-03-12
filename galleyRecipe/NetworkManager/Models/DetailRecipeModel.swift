//
//  DetailRecipe.swift
//  galleyRecipe
//
//  Created by garpun on 28.01.2023.
//

import Foundation
import RealmSwift

// MARK: - DetailRecipe
struct DetailRecipe: Decodable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let image: String?
    let extendedIngredients: [Ingredients]
    let analyzedInstructions: [Instruction]
}

extension DetailRecipe: ObjectAdapterProtocol {
    public init(managedObject: RealmFavoriteRecipe) {
        id = managedObject.id
        title = managedObject.title
        readyInMinutes = managedObject.readyInMinutes
        servings = managedObject.servings
        image = managedObject.image
        extendedIngredients = {
            var array: [Ingredients] = []
            managedObject.ingredients.forEach {
                array.append(Ingredients(managedObject: $0))
            }

            return array
        }()
        analyzedInstructions = {
            var array: [Instruction] = []
            managedObject.instruction.forEach {
                array.append(Instruction(managedObject: $0))
            }

            return array
        }()
    }

    public func managedObject() -> RealmFavoriteRecipe {
        let recipe = RealmFavoriteRecipe()
        recipe.id = id
        recipe.title = title
        recipe.readyInMinutes = readyInMinutes
        recipe.servings = servings
        recipe.image = image ?? ""
        recipe.instruction = {
            let list = List<RealmInstruction>()
            analyzedInstructions.forEach {
                list.append($0.managedObject())
            }
            return list
        }()

        recipe.ingredients = {
            let list = List<RealmIngredients>()
            extendedIngredients.forEach {
                list.append($0.managedObject())
            }
            return list
        }()

        return recipe
    }
}

// MARK: - Ingredients
struct Ingredients: Decodable {
    let originalName: String
    let measures: Measures
}

extension Ingredients: ObjectAdapterProtocol {
    public init(managedObject: RealmIngredients) {
        originalName = managedObject.originalName
        measures = Measures(managedObject: managedObject.measures)
    }

    public func managedObject() -> RealmIngredients {
        let ingredients = RealmIngredients()
        ingredients.originalName = originalName
        ingredients.measures = measures.managedObject()

        return ingredients
    }
}

// MARK: - Measures
struct Measures: Decodable {
    let metric: Metric
}

extension Measures: ObjectAdapterProtocol {
    public init(managedObject: RealmMeasures) {
        metric = Metric(managedObject: managedObject.metric)
    }

    public func managedObject() -> RealmMeasures {
        let measures = RealmMeasures()
        measures.metric = metric.managedObject()

        return measures
    }
}

// MARK: - Metric
struct Metric: Decodable {
    let amount: Double
    let unitShort: String
}

extension Metric: ObjectAdapterProtocol {
    public init(managedObject: RealmMetric) {
        amount = managedObject.amount
        unitShort = managedObject.unitShort
    }

    public func managedObject() -> RealmMetric {
        let metric = RealmMetric()
        metric.unitShort = unitShort
        metric.amount = amount

        return metric
    }
}

// MARK: - Instruction
struct Instruction: Decodable {
    let steps: [InstructionSteps]
}

extension Instruction: ObjectAdapterProtocol {
    public init(managedObject: RealmInstruction) {
        steps = {
            var array: [InstructionSteps] = []
            managedObject.realmSteps.forEach {
                array.append(InstructionSteps(managedObject: $0))
            }

            return array
        }()
    }

    public func managedObject() -> RealmInstruction {
        let realmInstruction = RealmInstruction()
        realmInstruction.realmSteps = {
            let list = List<RealmStep>()

            steps.forEach {
                list.append($0.managedObject())
            }

            return list
        }()

        return realmInstruction
    }
}
// MARK: - InstructionSteps
struct InstructionSteps: Decodable {
    let number: Int
    let step: String
}

extension InstructionSteps: ObjectAdapterProtocol {
    public init(managedObject: RealmStep) {
        number = managedObject.number
        step = managedObject.step
    }

    public func managedObject() -> RealmStep {
        let realmStep = RealmStep()
        realmStep.step = step
        realmStep.number = number

        return realmStep
    }
}
