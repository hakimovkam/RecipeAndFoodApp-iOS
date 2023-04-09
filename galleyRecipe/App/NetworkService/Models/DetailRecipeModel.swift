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
    let nutrition: Nutrition?
}

extension DetailRecipe: ObjectAdapterProtocol {
    public init(managedObject: RealmRecipe) {
        id = managedObject.id
        title = managedObject.title
        readyInMinutes = managedObject.readyInMinutes
        servings = managedObject.servings
        image = managedObject.image
        nutrition = Nutrition(managedObject: managedObject.nutrition)
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

    public func managedObject() -> RealmRecipe {
        let recipe = RealmRecipe()
        recipe.id = id
        recipe.title = title
        recipe.readyInMinutes = readyInMinutes
        recipe.servings = servings
        recipe.image = image ?? ""
        recipe.nutrition = nutrition?.managedObject()
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

// MARK: - Nutrition and Nutrients
struct Nutrition: Decodable {
    let nutrients: [Nutrients]
}

extension Nutrition: ObjectAdapterProtocol {
    public init(managedObject: RealmNutrition) {
        nutrients = {
            var array: [Nutrients] = []
            if let realmNutrient = managedObject.nutrients.first {
                array.append(Nutrients(managedObject: realmNutrient))
            }

            return array
        }()
    }

    public func managedObject() -> RealmNutrition {
        let realmNutrition = RealmNutrition()
        realmNutrition.nutrients = {
            let list = List<RealmNutrients>()
            list.append(nutrients[0] .managedObject())
            return list
        }()

        return realmNutrition
    }
}

struct Nutrients: Decodable {
    let name: String
    let amount: Double
    let unit: String
}

extension Nutrients: ObjectAdapterProtocol {
    public init(managedObject: RealmNutrients) {
        name = managedObject.name
        amount = managedObject.amount
        unit = managedObject.unit
    }

    public func managedObject() -> RealmNutrients {
        let realmNutrients = RealmNutrients()
        realmNutrients.name = name
        realmNutrients.unit = unit
        realmNutrients.amount = amount

        return realmNutrients
    }
}
// MARK: - Ingredients
struct Ingredients: Decodable {
    let originalName: String
    let measures: Measures
    let image: String
}

extension Ingredients: ObjectAdapterProtocol {
    public init(managedObject: RealmIngredients) {
        originalName = managedObject.originalName
        measures = Measures(managedObject: managedObject.measures)
        image = managedObject.image
    }

    public func managedObject() -> RealmIngredients {
        let ingredients = RealmIngredients()
        ingredients.originalName = originalName
        ingredients.measures = measures.managedObject()
        ingredients.image = image

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
