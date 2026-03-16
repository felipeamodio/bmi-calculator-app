//
//  ContentView.swift
//  BMI Calculator App
//
//  Created by Felipe Alves Amodio on 02/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = BMIViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                (viewModel.isDarkMode ? viewModel.customDark : viewModel.customGray)
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - Dark Mode Toggle
                    ThemeSwitcher(viewModel: viewModel)
                        .padding(.bottom, 20)
                    
                    ScrollView(showsIndicators: false) {
                        
                        // MARK: - Welcome Header
                        WelcomeHeader(isDarkMode: viewModel.isDarkMode)
                        
                        // MARK: - Gender Selection
                        GenderSelector(viewModel: viewModel)
                        
                        // MARK: - Name Input
                        VStack {
                            TextField("Your name", text: $viewModel.userData.name)
                                .padding()
                                .background(Color(.white))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.vertical, 12)
                        
                        // MARK: - Height, Weight, Age
                        HStack(spacing: 12) {
                            // Height Picker
                            HeightPicker(
                                selectedHeight: $viewModel.userData.height,
                                isDarkMode: viewModel.isDarkMode
                            )
                            .frame(width: 175, height: 460)
                            .background(viewModel.isDarkMode ? viewModel.customDark2 : Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            // Weight and Age
                            VStack(spacing: 12) {
                                WeightCard(viewModel: viewModel)
                                AgeCard(viewModel: viewModel)
                            }
                        }
                        
                        // MARK: - Calculate Button
                        Button {
                            viewModel.navigateToResults()
                        } label: {
                            Text("Let's go")
                        }
                        .navigationDestination(isPresented: $viewModel.navigateToResult) {
                            if let result = viewModel.bmiResult {
                                ResultBMI(
                                    result: result,
                                    isDarkMode: viewModel.isDarkMode
                                )
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(viewModel.customBlue)
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(25)
            }
        }
    }
}

// MARK: - Subviews

/// Theme switcher (Sun/Moon buttons)
struct ThemeSwitcher: View {
    @Bindable var viewModel: BMIViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                withAnimation(.easeInOut(duration: 1.5)) {
                    viewModel.setDarkMode(false)
                }
            } label: {
                Image(systemName: "sun.max.fill")
                    .foregroundStyle(viewModel.isDarkMode ? viewModel.customDark : .blue)
            }
            
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    viewModel.setDarkMode(true)
                }
            } label: {
                Image(systemName: "moon.fill")
                    .foregroundStyle(viewModel.isDarkMode ? .blue : viewModel.customGray)
            }
        }
        .frame(width: 85, height: 42)
        .background(viewModel.isDarkMode ? viewModel.customDark2 : .white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

/// Welcome header
struct WelcomeHeader: View {
    let isDarkMode: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Welcome 😁")
                .font(.default)
                .foregroundStyle(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("BMI Calculator")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

/// Gender selector buttons
struct GenderSelector: View {
    @Bindable var viewModel: BMIViewModel
    
    var body: some View {
        HStack {
            ForEach(Gender.allCases, id: \.self) { gender in
                Button(gender.rawValue) {
                    viewModel.userData.gender = gender
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(viewModel.userData.gender == gender ? viewModel.customBlue : Color.white)
                .foregroundStyle(viewModel.userData.gender == gender ? Color.white : viewModel.customBlue)
                .font(.system(
                    size: 18,
                    weight: viewModel.userData.gender == gender ? .bold : .medium,
                    design: .rounded
                ))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

/// Weight card with increment/decrement
struct WeightCard: View {
    @Bindable var viewModel: BMIViewModel
    
    var body: some View {
        VStack {
            Text("Weight")
                .font(.headline)
                .foregroundColor(viewModel.customGray2)
            
            Text("\(viewModel.userData.weight)")
                .font(.system(size: 56, weight: .semibold, design: .rounded))
                .padding(.vertical)
                .foregroundStyle(viewModel.isDarkMode ? Color.white : Color.black)
            
            HStack(spacing: 30) {
                StepperButton(symbol: "-") {
                    viewModel.decrementWeight()
                }
                
                StepperButton(symbol: "+") {
                    viewModel.incrementWeight()
                }
            }
        }
        .frame(width: 175, height: 224)
        .background(viewModel.isDarkMode ? viewModel.customDark2 : Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

/// Age card with increment/decrement
struct AgeCard: View {
    @Bindable var viewModel: BMIViewModel
    
    var body: some View {
        VStack {
            Text("Age")
                .font(.headline)
                .foregroundColor(viewModel.customGray2)
            
            Text("\(viewModel.userData.age)")
                .font(.system(size: 56, weight: .semibold, design: .rounded))
                .padding(.vertical)
                .foregroundStyle(viewModel.isDarkMode ? Color.white : Color.black)
            
            HStack(spacing: 30) {
                StepperButton(symbol: "-") {
                    viewModel.decrementAge()
                }
                
                StepperButton(symbol: "+") {
                    viewModel.incrementAge()
                }
            }
        }
        .frame(width: 175, height: 224)
        .background(viewModel.isDarkMode ? viewModel.customDark2 : Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

/// Reusable stepper button
struct StepperButton: View {
    let symbol: String
    let action: () -> Void
    
    let customBlue = Color(red: 36/255, green: 106/255, blue: 254/255)
    
    var body: some View {
        Button(action: action) {
            Text(symbol)
                .font(.title)
                .fontWeight(.semibold)
        }
        .frame(width: 42, height: 42)
        .background(customBlue)
        .foregroundStyle(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
