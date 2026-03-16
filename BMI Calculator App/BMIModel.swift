//
//  BMIModel.swift
//  BMI Calculator App
//
//  Created by Felipe Alves Amodio on 16/03/26.
//

import SwiftUI

// MARK: - Models

/// Represents user data for BMI calculation
struct UserData {
    var name: String = ""
    var gender: Gender = .male
    var weight: Int = 70
    var age: Int = 18
    var height: Int = 170
}

/// Gender options
enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

/// BMI Result with category information
struct BMIResult {
    let bmi: Double
    let category: BMICategory
    let userName: String
    let userGender: Gender
    
    init(bmi: Double, userName: String, userGender: Gender) {
        self.bmi = bmi
        self.userName = userName
        self.userGender = userGender
        self.category = BMICategory.category(for: bmi)
    }
}

/// BMI Categories with associated information
enum BMICategory {
    case underweight
    case normal
    case overweight
    case obese
    
    static func category(for bmi: Double) -> BMICategory {
        switch bmi {
        case ..<18.5:
            return .underweight
        case 18.5..<25:
            return .normal
        case 25..<30:
            return .overweight
        default:
            return .obese
        }
    }
    
    var label: String {
        switch self {
        case .underweight: return "Underweight"
        case .normal: return "Normal weight"
        case .overweight: return "Overweight"
        case .obese: return "Obese"
        }
    }
    
    var color: Color {
        switch self {
        case .underweight: return .orange
        case .normal: return .green
        case .overweight: return .yellow
        case .obese: return .red
        }
    }
    
    func message(for name: String) -> String {
        switch self {
        case .underweight:
            return "Your body may need more fuel, \(name). Focus on nutrient-rich foods and a balanced diet. 🥗"
        case .normal:
            return "You're in great shape, \(name)! Keep up your healthy habits and stay active. 💪"
        case .overweight:
            return "A few adjustments can make a big difference, \(name). Small steps lead to great results. 🚶"
        case .obese:
            return "It's never too late to start, \(name). Consider talking to a health professional for guidance. ❤️"
        }
    }
}
