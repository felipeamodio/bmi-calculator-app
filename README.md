# BMI Calculator App 📊

A beautiful and intuitive BMI (Body Mass Index) calculator built with SwiftUI and MVVM architecture. Calculate your BMI and get personalized health insights!

![Gif BMI Calculator](https://github.com/felipeamodio/bmi-calculator-app/blob/main/bmi.gif)

## Overview

BMI Calculator App is an iOS application that helps you calculate your Body Mass Index and provides personalized health recommendations based on your results. With its clean interface, smooth animations, and dark mode support, tracking your BMI has never been easier.

## Features

- **🌓 Dark Mode Support**: Seamlessly switch between light and dark themes with animated transitions
- **👤 Gender Selection**: Choose your gender for personalized results
- **📏 Interactive Height Picker**: Drag-and-drop height selector with visual feedback (112-190 cm)
- **⚖️ Weight Input**: Easy increment/decrement controls for precise weight entry
- **🎂 Age Tracking**: Track your age alongside BMI calculations
- **📊 Circular Progress Indicator**: Beautiful animated progress ring showing your BMI score
- **🎨 Category-Based Results**: Color-coded BMI categories (Underweight, Normal, Overweight, Obese)
- **💬 Personalized Messages**: Get custom health recommendations based on your results
- **🏗️ MVVM Architecture**: Clean, maintainable, and testable code structure
- **✨ Smooth Animations**: Delightful transitions and feedback throughout the app

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/felipeamodio/bmi-calculator-app.git
```

2. Open the project in Xcode:
```bash
cd bmi-calculator-app
open BMI\ Calculator\ App.xcodeproj
```

3. Build and run the project on your simulator or device

## Usage

1. **Choose Theme**: Tap the sun ☀️ or moon 🌙 icon to switch between light and dark modes
2. **Select Gender**: Choose Male or Female
3. **Enter Your Name**: Type your name in the text field
4. **Set Height**: Drag the height selector to your height (in cm)
5. **Set Weight**: Use +/- buttons to set your weight (in kg)
6. **Set Age**: Use +/- buttons to enter your age
7. **Calculate**: Tap "Let's go" to see your BMI results

The results screen will display:
- **BMI Score**: Your calculated Body Mass Index with animated circular progress
- **Category**: Your BMI category with color coding
- **Personalized Message**: Custom health recommendations based on your results

## Code Structure

```
BMI Calculator App/
├── Models/
│   └── BMIModel.swift              # Data models and BMI categories
├── ViewModels/
│   └── BMIViewModel.swift          # Business logic and state management
├── Views/
│   ├── ContentView.swift           # Main input screen with component views
│   ├── ResultBMI.swift             # Results screen with circular progress
│   └── Height.swift                # Custom height picker component
├── Assets.xcassets/                # App assets and colors
└── README.md                       # This file
```

### Architecture - MVVM Pattern

#### Model Layer (`BMIModel.swift`)
- **UserData**: Stores user input (name, gender, weight, age, height)
- **Gender**: Type-safe enum for gender selection
- **BMIResult**: Encapsulates calculated BMI with category info
- **BMICategory**: Enum defining BMI categories with associated colors and messages

#### ViewModel Layer (`BMIViewModel.swift`)
- **BMIViewModel**: Observable class managing all app state and business logic
  - User data management
  - BMI calculation logic
  - Theme state (dark/light mode)
  - Navigation control
  - Helper methods for weight/age adjustments

#### View Layer
- **ContentView**: Main calculator interface
  - Broken into small, reusable components:
    - `ThemeSwitcher`: Dark/light mode toggle
    - `WelcomeHeader`: Welcome message
    - `GenderSelector`: Gender selection buttons
    - `WeightCard`: Weight input with steppers
    - `AgeCard`: Age input with steppers
    - `StepperButton`: Reusable increment/decrement button
- **ResultBMI**: Results display screen
  - `CircularProgressView`: Animated BMI progress ring
- **HeightPicker**: Custom draggable height selector

## Technical Highlights

### MVVM Architecture
Clean separation of concerns with Model-View-ViewModel pattern:
```swift
@Observable
class BMIViewModel {
    var userData = UserData()
    var isDarkMode = false
    var navigateToResult = false
    
    func calculateBMI() -> Double? {
        guard userData.weight > 0 else { return nil }
        let heightInMeters = Double(userData.height) / 100.0
        return Double(userData.weight) / (heightInMeters * heightInMeters)
    }
}
```

### Smart BMI Categorization
Automatic category detection with color-coded results:
```swift
enum BMICategory {
    case underweight  // < 18.5 (Orange)
    case normal       // 18.5 - 24.9 (Green)
    case overweight   // 25 - 29.9 (Yellow)
    case obese        // > 30 (Red)
}
```

### Animated Circular Progress
Beautiful progress ring with smooth animations:
```swift
Circle()
    .trim(from: 0, to: animatedProgress)
    .stroke(customBlue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
    .rotationEffect(.degrees(-90))
```

### Custom Height Picker
Interactive drag-to-select height component with real-time feedback:
```swift
GeometryReader { geo in
    ZStack(alignment: .bottom) {
        Capsule().fill(Color(.systemGray5))
        Capsule().fill(Color.blue)
            .frame(height: fillHeight(in: geo.size.height))
    }
    .gesture(DragGesture()...)
}
```

### Theme Switching
Smooth animated transitions between light and dark modes:
```swift
withAnimation(.easeInOut(duration: 1.5)) {
    viewModel.setDarkMode(false)
}
```

## BMI Categories Reference

| Category | BMI Range | Color | Health Indication |
|----------|-----------|-------|-------------------|
| Underweight | < 18.5 | 🟠 Orange | May need more nutrients |
| Normal Weight | 18.5 - 24.9 | 🟢 Green | Healthy range |
| Overweight | 25 - 29.9 | 🟡 Yellow | Consider lifestyle changes |
| Obese | ≥ 30 | 🔴 Red | Consult health professional |

## Future Enhancements

Potential features to add:
- [ ] Save BMI history and track progress over time
- [ ] Charts showing BMI trends
- [ ] Support for imperial units (feet/inches, pounds)
- [ ] BMI-for-age percentiles for children
- [ ] Health tips and exercise recommendations
- [ ] Integration with HealthKit
- [ ] Widget for quick BMI viewing
- [ ] Share results with friends or healthcare providers
- [ ] Multiple user profiles
- [ ] Reminder notifications for regular tracking

## Code Quality

- ✅ MVVM Architecture for clean separation of concerns
- ✅ Type-safe enums and structs
- ✅ Reusable SwiftUI components
- ✅ Modern Swift Observation framework
- ✅ No force unwrapping or implicitly unwrapped optionals
- ✅ Comprehensive property documentation
- ✅ Organized with MARK comments
- ✅ Follows Swift naming conventions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is available for personal and educational use.

## Author

**Felipe Alves Amodio**

## Acknowledgments

- Built with SwiftUI and Swift 6
- Uses the `@Observable` macro for modern state management
- Designed for iOS 17+
- Color palette inspired by modern iOS design principles
- BMI calculation formula based on WHO standards

---

Made with ❤️ using SwiftUI
