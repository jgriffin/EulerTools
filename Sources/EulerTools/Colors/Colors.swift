//
// Created by John Griffin on 1/9/24
//

import SwiftUI

public extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0

        Scanner(string: cleanHexCode).scanHexInt64(&rgb)

        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

public extension [Color] {
    var iterator: AnyIterator<Color> {
        var i = 0
        return AnyIterator {
            defer { i = i + 1 % self.count }
            return self[i]
        }
    }

    static let blueToYellow: [Color] = [
        "#115f9a", "#1984c5", "#22a7f0", "#48b5c4", "#76c68f", "#a6d75b", "#c9e52f", "#d0ee11", "#f4f100",
    ].map(Color.init)

    static let springPastels: [Color] = [
        "#fd7f6f", "#7eb0d5", "#b2e061", "#bd7ebe", "#ffb55a", "#ffee65", "#beb9db", "#fdcce5", "#8bd3c7",
    ].map(Color.init)

    static let salmonToAqua: [Color] = [
        "#e27c7c", "#a86464", "#6d4b4b", "#503f3f", "#333333", "#3c4e4b", "#466964", "#599e94", "#6cd4c5",
    ].map(Color.init)

    static let retroMetro: [Color] = [
        "#ea5545", "#f46a9b", "#ef9b20", "#edbf33", "#ede15b", "#bdcf32", "#87bc45", "#27aeef", "#b33dc6",
    ].map(Color.init)
}

#Preview {
    struct ColorBar: View {
        let title: String
        let colors: [Color]
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                HStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in color }
                }
                .frame(height: 40)
            }
        }
    }

    return VStack {
        ColorBar(title: ".blueToYellow", colors: .blueToYellow)
        ColorBar(title: ".springPastels", colors: .springPastels)
        ColorBar(title: ".retroMetro", colors: .retroMetro)
        ColorBar(title: ".salmonToAqua", colors: .salmonToAqua)
    }.padding()
}
