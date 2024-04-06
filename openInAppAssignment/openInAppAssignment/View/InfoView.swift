import SwiftUI


struct InfoView: View {
    @StateObject var viewModel = DashboardViewModel()

    struct InfoItem {
        let imageName: String
        let title: String
        let subtitle: String
    }

    let infoItems: [InfoItem] = [
        InfoItem(imageName: "totalClicks", title: "Today’s clicks", subtitle: ""),
        InfoItem(imageName: "Location", title: "Top Locations", subtitle: ""),
        InfoItem(imageName: "social", title: "Top source", subtitle: ""),
        InfoItem(imageName: "bedTime", title: "Best Time", subtitle: "")
    ]

    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(infoItems, id: \.title) { item in
                    ZStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Image(item.imageName)
                            Text(viewModelSubtitle(for: item.title))
                                .font(Font.custom("Figtree", size: 14))
                                .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.63))
                            Text(item.title)
                                 .font(Font.custom("Figtree", size: 16).weight(.semibold))
                                 .lineLimit(2)
                        }
                        .frame(width: 120, height: 120)
                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                        .cornerRadius(8)
                        .onAppear {
                            fetchData(for: item.title)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }

    private func fetchData(for title: String) {
        viewModel.fetchDashboardData()
    }

    private func viewModelSubtitle(for title: String) -> String {
        switch title {
        case "Today’s clicks":
            return "\(viewModel.dashboardResponse?.today_clicks ?? 0)"
        case "Top Locations":
            return viewModel.dashboardResponse?.top_location ?? ""
        case "Top source":
            return viewModel.dashboardResponse?.top_source ?? ""
        case "Best Time":
            return viewModel.dashboardResponse?.startTime ?? ""
        default:
            return ""
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
