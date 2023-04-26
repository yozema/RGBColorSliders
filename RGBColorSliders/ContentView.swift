//
//  ContentView.swift
//  RGBColorSliders
//
//  Created by Ilya Zemskov on 23.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSlider = 80.0
    @State private var greenSlider = 100.0
    @State private var blueSlider = 200.0
    
    var body: some View {
        ZStack {
            Color(.systemCyan).ignoresSafeArea()
            VStack {
                ColorView(
                    redValue: $redSlider,
                    greenValue: $greenSlider,
                    blueValue: $blueSlider
                )
                ColorSliderView(color: .red, value: $redSlider)
                ColorSliderView(color: .green, value: $greenSlider)
                ColorSliderView(color: .blue, value: $blueSlider)
                Spacer()
            }
            .padding(.top)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done", action: hidesKeyboard)
                }
            }
        }
        .onTapGesture { hidesKeyboard() }
    }
    
    private func hidesKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    let color: Color
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width * 0.1)
                .bold()
                .padding(.leading)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
                .animation(.default, value: value)
            TextField("1", value: $value, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .frame(width: UIScreen.main.bounds.width * 0.15)
                .bold()
                .multilineTextAlignment(.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .keyboardType(.decimalPad)
                .padding(.trailing)
        }
    }
}

struct ColorView: View {
    @Binding var redValue: Double
    @Binding var greenValue: Double
    @Binding var blueValue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(
                Color(
                    red: Double(redValue) / 255.0,
                    green: Double(greenValue) / 255.0,
                    blue: Double(blueValue) / 255.0
                )
            )
            .frame(height: UIScreen.main.bounds.height * 0.2)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 20).stroke(Color.white, lineWidth: 4)
            )
            .padding()
    }
}


