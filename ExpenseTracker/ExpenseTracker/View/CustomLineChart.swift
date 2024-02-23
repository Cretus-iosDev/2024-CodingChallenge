
import SwiftUI

struct CustomLineChart: View {
    let dataPoints: [Double]
    let labels: [String]

    var body: some View {
        VStack {
            // Y-axis with grid lines and labels
            VStack {
                ForEach(labels.reversed(), id: \.self) { label in
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 40)

            // Chart area with X-axis and data points
            HStack {
                // Y-axis with grid lines
                VStack(alignment: .trailing, spacing: 20) {
                    ForEach(0..<labels.count, id: \.self) { _ in
                        Divider()
                            .background(Color.gray)
                    }
                }
                .frame(width: 40)

                // Data points
                GeometryReader { geometry in
                    Path { path in
                        for i in 0..<dataPoints.count {
                            let x = geometry.size.width / CGFloat(dataPoints.count - 1) * CGFloat(i)
                            let y = geometry.size.height * (1 - CGFloat(dataPoints[i]) / CGFloat(dataPoints.max() ?? 1))
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                }
                .padding(.leading, 20)
            }

            // X-axis labels
            HStack {
                ForEach(labels.indices, id: \.self) { index in
                    Text(labels[index])
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: UIScreen.main.bounds.width / CGFloat(labels.count), alignment: .center)
                }
            }
            .padding(.leading, 60)
        }
    }
}




struct CustomLineChart_Previews: PreviewProvider {
    static var previews: some View {
        CustomLineChart(dataPoints: [100, 200, 300, 400, 500], labels: ["Mon", "Tue", "Wed", "Thu", "Fri"])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
