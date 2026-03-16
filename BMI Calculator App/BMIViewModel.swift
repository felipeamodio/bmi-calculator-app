//
//  BMIViewModel.swift
//  BMI Calculator App
//
//  Created by Felipe Alves Amodio on 16/03/26.
//

import SwiftUI

/// ViewModel managing BMI calculator state and business logic
@Observable
class BMIViewModel {
    
    // MARK: - Published Properties
    
    /// User input data
    var userData = UserData()
    
    /// Dark mode state
    var isDarkMode = false
    
    /// Navigation state
    var navigateToResult = false
    
    /// Computed BMI result
    var bmiResult: BMIResult? {
        guard let bmi = calculateBMI() else { return nil }
        return BMIResult(
            bmi: bmi,
            userName: userData.name.isEmpty ? "Guest" : userData.name,
            userGender: userData.gender
        )
    }
    
    // MARK: - Constants
    
    let customGray = Color(red: 209/255, green: 217/255, blue: 230/255)
    let customGray2 = Color(red: 140/255, green: 140/255, blue: 140/255)
    let customDark = Color(red: 36/255, green: 36/255, blue: 36/255)
    let customDark2 = Color(red: 55/255, green: 55/255, blue: 55/255)
    let customBlue = Color(red: 36/255, green: 106/255, blue: 254/255)
    
    let heightRange = 112...190
    
    // MARK: - Methods
    
    /// Calculate BMI from current user data
    func calculateBMI() -> Double? {
        guard userData.weight > 0 else { return nil }
        let heightInMeters = Double(userData.height) / 100.0
        return Double(userData.weight) / (heightInMeters * heightInMeters)
    }
    
    /// Increment weight by 1
    func incrementWeight() {
        userData.weight += 1
    }
    
    /// Decrement weight by 1, minimum 0
    func decrementWeight() {
        userData.weight = max(0, userData.weight - 1)
    }
    
    /// Increment age by 1
    func incrementAge() {
        userData.age += 1
    }
    
    /// Decrement age by 1, minimum 0
    func decrementAge() {
        userData.age = max(0, userData.age - 1)
    }
    
    /// Toggle dark mode with animation
    func setDarkMode(_ enabled: Bool) {
        isDarkMode = enabled
    }
    
    /// Attempt to navigate to results
    func navigateToResults() {
        guard calculateBMI() != nil else { return }
        navigateToResult = true
    }
    
    /// Calculate progress value (0.0 to 1.0) for circular progress indicator
    func bmiProgress(bmi: Double) -> Double {
        // Map BMI range (10-40) to progress (0.0-1.0)
        let minBMI = 10.0
        let maxBMI = 40.0
        let clamped = min(max(bmi, minBMI), maxBMI)
        return (clamped - minBMI) / (maxBMI - minBMI)
    }
}
