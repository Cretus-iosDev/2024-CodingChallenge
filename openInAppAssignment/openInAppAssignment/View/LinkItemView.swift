import SwiftUI

// Struct to represent a sample link item
struct LinkItem: Identifiable, Hashable {
    let id = UUID()
    let linkName: String
    let date: String
    let clicks: String
    let linkURL: String
    let image: String
}

struct SampleLinkItemView: View {
    // Dummy data for link items
    let dummyData: [LinkItem] = [
        LinkItem(linkName: "651   Flats for Rent in Kormangla Bangalore, Bangalore Karnataka Without Brokerage - NoBroker Rental Properties in Kormangla Bangalore Karnataka Without Brokerage", date: "1 yr ago", clicks: "202", linkURL: "https://inopenapp.com/4o5qk", image: "img-1"),
        LinkItem(linkName: "Dailyhunt", date: "1 yr ago", clicks: "98", linkURL: "https://inopenapp.com/estt3", image: "img-2"),
        LinkItem(linkName: "MSI Katana GF66 Thin, Intel 12th Gen. i5-12450H, 40CM FHD 144Hz Gaming Laptop (16GB/512GB NVMe SSD/Windows 11 Home/Nvidia RTX3050Ti 4GB GDDR6/Black/2.25Kg), 12UD-640IN : Amazon.in: Computers & Accessories", date: "1 yr ago", clicks: "64", linkURL: "https://inopenapp.com/7113t", image: "img-3"),
        LinkItem(linkName: "Online Shopping Site for Mobiles, Electronics, Furniture, Grocery, Lifestyle, Books & More. Best Offers!", date: "1 yr ago", clicks: "57", linkURL: "https://samplelink5.oia.bio/ashd...", image: "img-1")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(dummyData) { item in
                    LinkItemContent(linkItem: item)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

private struct LinkItemContent: View {
    let linkItem: LinkItem

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                LinkImageView(linkItem: linkItem)
                LinkInfoView(linkItem: linkItem)
            }
            LinkURLView(linkURL: linkItem.linkURL)
        }
    }
}

private struct LinkImageView: View {
    let linkItem: LinkItem
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 48, height: 48)
                .background(
                    Image(linkItem.image)
                    
                )
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 0.50)
                )
        }
        .frame(width: 48, height: 48)
    }
}

private struct LinkInfoView: View {
    let linkItem: LinkItem

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(linkItem.linkName)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Figtree", size: 14))
                    .foregroundColor(.black)
                Text(linkItem.date)
                    .font(Font.custom("Figtree", size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.63))
            }
            Spacer()
            VStack(spacing: 4) {
                Text(linkItem.clicks)
                    .font(Font.custom("Figtree", size: 14).weight(.semibold))
                    .foregroundColor(.black)
                Text("Clicks")
                    .font(Font.custom("Figtree", size: 12))
                    .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.63))
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct LinkURLView: View {
    let linkURL: String

    var body: some View {
        HStack {
            Text(linkURL)
                .font(Font.custom("Figtree", size: 14))
                .foregroundColor(Color(red: 0.05, green: 0.44, blue: 1))
            Spacer()
        }
        .frame(height: 24)
        .padding(EdgeInsets(top: 4.88, leading: 6.38, bottom: 4.88, trailing: 6.12))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.65, green: 0.78, blue: 1), lineWidth: 0.50)
        )
    }
}

// Preview
struct SampleLinkItemView_Previews: PreviewProvider {
    static var previews: some View {
        SampleLinkItemView()
    }
}
