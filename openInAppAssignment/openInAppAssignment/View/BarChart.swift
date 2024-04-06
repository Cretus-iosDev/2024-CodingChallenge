import SwiftUI
import Charts

struct BarChart: View {
    let catData = PetData.catExample
    
    @State private var selectedDate = Date()
    
    var body: some View {
            VStack {
                DatePicker("OverView", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                
                Chart {
                    ForEach(catData) { data in
                        LineMark(x: .value("Year", data.year),
                                 y: .value("Population", data.population))
                    }
                    .interpolationMethod(.cardinal)
                    .symbol(by: .value("Pet type", "cat"))
                    ForEach(catData) { data in
                        AreaMark(x: .value("Year", data.year),
                                 y: .value("Population", data.population))
                    }
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(linearGradient)
                }
                .chartXScale(domain: 1998...2024)
                .chartLegend(.hidden)
                .chartXAxis {
                    AxisMarks(values: [2000, 2010, 2015, 2022]) { value in
                        AxisGridLine()
                        AxisTick()
                        if let year = value.as(Int.self) {
                            AxisValueLabel("\(year)",
                                           centered: false,
                                           anchor: .top)
                        }
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .padding(.horizontal,25)
            }
           
        }
    
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]),
                                         startPoint: .top,
                                         endPoint: .bottom)
}

#Preview {
    BarChart()
}



