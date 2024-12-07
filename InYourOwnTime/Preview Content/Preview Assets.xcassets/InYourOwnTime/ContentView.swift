//
//  ContentView.swift
//  In Your Own Time (v3)
//
//  Created by Lucas on 22/11/2024.
//
import SwiftUI

struct ContentView: View {
    @State private var currentTime = Date()

    var body: some View {
        VStack {
            // Title
            Text("In Your Own Time")
                .font(.system(size: 35, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .padding(.top, 30) // Increase this value to push the clock down more
                .padding()

            // Digital Clock
            Text(getTimeString(from: currentTime))
                .font(.system(size: 50, design: .monospaced))
                .foregroundColor(.white)
                .padding(.top, 80) // Increase this value to push the clock down more
                .padding()

            ZStack {
                Color("LightBlue").ignoresSafeArea()

                // Clock face
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 300)

                // Hour markers
                ForEach(0..<12) { i in
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2, height: 15)
                        .offset(y: -143)
                        .rotationEffect(.degrees(Double(i) * 30))
                }

                // Clock hands
                Hand(length: 100, width: 4, angle: hoursAngle)
                Hand(length: 120, width: 2, angle: minutesAngle)
                Hand(length: 140, width: 1, angle: secondsAngle, color: .white)

                // Center of the clock
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
            }

            Spacer()
            Spacer()
            Spacer()
        }
        .background(Color("LightBlue")) // Background color
        .onAppear {
            // Update the clock every second
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }

    // Calculate angles for the hands
    private var secondsAngle: Angle {
        let seconds = Calendar.current.component(.second, from: currentTime)
        return .degrees(Double(seconds) * 6) // 360° / 60 = 6 degrees per second
    }

    private var minutesAngle: Angle {
        let minutes = Calendar.current.component(.minute, from: currentTime)
        return .degrees(Double(minutes) * 6)
    }

    private var hoursAngle: Angle {
        let hours = Calendar.current.component(.hour, from: currentTime) % 12
        let minutes = Calendar.current.component(.minute, from: currentTime)
        return .degrees(Double(hours) * 30 + Double(minutes) * 0.5) // 360 degrees / 12 = 30 degrees per hour
    }

    // Function to format the current time into a digital string
    private func getTimeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
}

struct Hand: View {
    let length: CGFloat
    let width: CGFloat
    let angle: Angle
    let color: Color

    init(length: CGFloat, width: CGFloat, angle: Angle, color: Color = .white) {
        self.length = length
        self.width = width
        self.angle = angle
        self.color = color
    }

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: length)
            .offset(y: -length / 2)
            .rotationEffect(angle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
