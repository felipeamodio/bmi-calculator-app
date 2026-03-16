//
//  ResultBMI.swift
//  BMI Calculator App
//
//  Created by Felipe Alves Amodio on 15/03/26.
//

import SwiftUI

struct ResultBMI: View {
    @State private var animatedProgress: Double = 0
    
    let result: BMIResult
    let isDarkMode: Bool
    
    let customBlue = Color(red: 36/255, green: 106/255, blue: 254/255)
    let customGray  = Color(red: 209/255, green: 217/255, blue: 230/255)
    let customDark = Color(red: 36/255, green: 36/255, blue: 36/255)
    let customDark2 = Color(red: 55/255, green: 55/255, blue: 55/255)

    var progress: Double {
        min(max((result.bmi - 10) / 30, 0), 1)
    }

    var body: some View {
        ZStack {
            // Background
            (isDarkMode ? customDark : customGray)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {

                // MARK: - Circular Progress
                CircularProgressView(
                    progress: animatedProgress,
                    bmi: result.bmi,
                    isDarkMode: isDarkMode
                )

                // MARK: - Category Badge
                Text(result.category.label)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(result.category.color)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(result.category.color.opacity(0.15))
                    .clipShape(Capsule())

                // MARK: - Personalized Message
                Text(result.category.message(for: result.userName))
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(isDarkMode ? .white : .secondary)
                    .padding(.horizontal, 32)

                Spacer()
            }
            .onAppear {
                // Animate progress after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 1.2)) {
                        animatedProgress = progress
                    }
                }
            }
            .padding(.top, 40)
        }
        .navigationTitle("Result for \(result.userName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
// MARK: - Circular Progress View

struct CircularProgressView: View {
    let progress: Double
    let bmi: Double
    let isDarkMode: Bool
    
    let customBlue = Color(red: 36/255, green: 106/255, blue: 254/255)
    let customGray  = Color(red: 209/255, green: 217/255, blue: 230/255)
    let customDark2 = Color(red: 55/255, green: 55/255, blue: 55/255)
    
    var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(isDarkMode ? customDark2 : customGray, lineWidth: 20)
                .frame(width: 220, height: 220)

            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    customBlue,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .frame(width: 220, height: 220)
                .rotationEffect(.degrees(-90))

            // Center content
            VStack(spacing: 4) {
                Text(String(format: "%.1f", bmi))
                    .font(.system(size: 52, weight: .bold, design: .rounded))
                    .foregroundStyle(customBlue)

                Text("BMI")
                    .font(.caption)
                    .foregroundStyle(isDarkMode ? .white : .secondary)
                    .textCase(.uppercase)
                    .kerning(2)
            }
        }
    }
}

