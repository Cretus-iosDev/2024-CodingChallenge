import SwiftUI

struct TabBarView: View {
    
    @State var selected: Tab = .Links
    @State var showMenu = false
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    
                    Spacer()
                    
                    switch selected {
                    case .Links:
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 36) {
                                GreetingView()
                                    .padding(.trailing,180)
                                BarChart()
                                InfoView()
                                ViewAnalyticsButton()
                                SegmentView()
                                ViewAllLinksButton()
                                TWSView()
                                FAQView()
                            }
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                        }
                    case .Courses:
                        Text("")
                    case .Campaigns:
                        Text("")
                    case .Profile:
                        Text("")
                    }
                    
                    Spacer()
                    
                    ZStack {
                        HStack {
                            TabBarItemView(selected: $selected, tab: .Links, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .Courses, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            
                            Button{}label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                                    .foregroundColor(.accentColor)
                                    .rotationEffect(Angle(degrees: showMenu ? 135 : 0))
                            }
                            .offset(y: -geometry.size.height/8/2)
                            
                            
                            
                            TabBarItemView(selected: $selected, tab: .Campaigns, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .Profile, width: geometry.size.width/5, height: geometry.size.height/28)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color("TabBarBackground").shadow(radius: 2))
                    }
                }
                
                .edgesIgnoringSafeArea(.bottom)
            }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


enum Tab: String {
    
    case Links = "links"
    case Courses = "Courses"
    case Campaigns = "Campaigns"
    case Profile = "Profile"
    
    var image: String {
        switch self {
        case .Links: return "link"
        case .Courses: return "book"
        case .Campaigns: return "horn"
        case .Profile: return "person"
        }
    }
}



