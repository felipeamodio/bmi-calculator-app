//
//  Height.swift
//  BMI Calculator App
//
//  Created by Felipe Alves Amodio on 14/03/26.
//

import SwiftUI

struct HeightPicker: View {
    @Binding var selectedHeight: Int
    var isDarkMode: Bool = false
    let minHeight = 112
    let maxHeight = 190
    
    let customGray2 = Color(red: 140/255, green: 140/255, blue: 140/255) // setting the background (#8C8C8C)
    let customDark2 = Color(red: 55/255, green: 55/255, blue: 55/255) // setting the background (#373737)

    var body: some View {
        VStack(spacing: 20) {
            Text("Height")
                .font(.headline)
                .foregroundColor(customGray2)

            HStack(spacing: 16) {
                GeometryReader { geo in
                    ZStack(alignment: .bottom) {
                        Capsule()
                            .fill(Color(.systemGray5))
                            .frame(width: 28)

                        Capsule()
                            .fill(Color.blue)
                            .frame(
                                width: 28,
                                height: fillHeight(in: geo.size.height)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                updateHeight(
                                    y: value.location.y,
                                    total: geo.size.height
                                )
                            }
                    )
                }
                .frame(width: 28)

                // Labels laterais
                VStack {
                    ForEach(stride(
                        from: maxHeight,
                        through: minHeight,
                        by: -10
                    ).map { $0 }, id: \.self) { h in
                        HStack(spacing: 6) {
                            Rectangle()
                                .fill(Color(.systemGray3))
                                .frame(width: 12, height: 1)
                            Text("\(h)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        if h != minHeight {
                            Spacer()
                        }
                    }
                }
            }
            .frame(height: 300)

            Text("\(selectedHeight) cm")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(isDarkMode ? Color.white : Color.black)
        }
        .padding()
    }

    func fillHeight(in total: CGFloat) -> CGFloat {
        let range = maxHeight - minHeight
        let ratio = CGFloat(selectedHeight - minHeight) / CGFloat(range)
        return total * ratio
    }

    func updateHeight(y: CGFloat, total: CGFloat) {
        let ratio = 1 - (y / total)
        let range = maxHeight - minHeight
        let value = Int(ratio * CGFloat(range)) + minHeight
        selectedHeight = min(maxHeight, max(minHeight, value))
    }
}

#Preview {
    HeightPicker(selectedHeight: .constant(170))
}
