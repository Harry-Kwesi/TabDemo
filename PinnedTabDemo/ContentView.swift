//
//  ContentView.swift
//  PinnedTabDemo
//
//  Created by Harry Kwesi De Graft on 14/12/23.
//

import SwiftUI

struct ContentView: View {
       
    @State var headerOffsets:(CGFloat, CGFloat) = (0,0)
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading,spacing: 0) {
                HeaderView()
                Text("Latest")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.top,15)
                      
//Pinned Header with Content
                LazyVStack(pinnedViews: [.sectionHeaders]){
                    Section{
                        GridView()
                    } header: {
                        PinnedHeaderView()
                            .background(Color.white)
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1/8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: true))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                            .padding(.bottom,-20)
                    }
                    
                }
                
            }
        }
        .overlay(content: {
            Rectangle()
                .fill(.white)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
        })
       .coordinateSpace(name:"SCROLL" )
       .ignoresSafeArea(.container, edges: .vertical)
    }

    
    
    // Header
    @ViewBuilder
    func HeaderView() -> some View {
        HorizontalBoxScrollView()
            .padding(.top, 5)
    }
    
    // Pinned Header
    @ViewBuilder
    func PinnedHeaderView() -> some View{
        
        let buttonTitles = ["Trending", "Technology", "Events", "News", "Rewards", "Campaigns", "Updates"]
            
        @State var activeButtonIndex: Int = 0
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) { 
                ForEach(0..<buttonTitles.count, id:\.self) { index in
                    Button(action: {
                        activeButtonIndex = index
                    }) {
                        Text(buttonTitles[index])
                            .font(.system(size: 10))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .foregroundColor(index == activeButtonIndex ? .white : .gray)
                    .background(index == activeButtonIndex ? Color.red : Color.gray.opacity(0.2))
                    .cornerRadius(9)
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 52)
            .padding(.bottom, 10)
            .padding(.vertical, 2)
        }
        .padding()
        .padding(.top, -40)

    }
}



struct GridView: View {
    @State private var initialItems: [Item] = [
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "torsten", title: "Adventure Timepiece", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "pixy", title: "Magical Creature ", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Sleek and Elegant", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "tesla", title: "Electric Dream", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "park", title: "Serene Park View", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "tesla", title: "Electric Dream", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "park", title: "Serene Park View", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "tesla", title: "Electric Dream", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "park", title: "Serene Park View", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "pixy", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "tesla", title: "Electric Dream", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "park", title: "Serene Park View", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "pixy", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "pixy", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
    ]
    
    
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(initialItems) { item in
                CardView(item: item)
            }
        }
        .padding()
        .padding(.bottom, 20)
    }
}



struct CardView: View {
    let item: Item

    var body: some View {
        VStack {
            Image("benzo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 170)

            VStack(alignment: .leading) {
                Text("01 Aug 2023 | Technology ")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.top, 8) 
                    .padding(.horizontal)

                Text("Qorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est...")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .frame(width: 180)
                    .padding(.top, 4)
                    .padding(.bottom)
            }
            .frame(width: 180) 
            .background(Color.primary.opacity(0.04))
            .padding(.top, -8)

        }
        .cornerRadius(8)
    }
}



struct HorizontalBoxScrollView: View {
    @State private var items: [Item] = [
        .init(imageName: "benz", title: "Luxury Car 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "torsten", title: "Adventure Timepiece", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "pixy", title: "Magical Creature Companion", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "benzo", title: "Sleek and Elegant", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..."),
        .init(imageName: "tesla", title: "Electric Dream", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est.."),
        .init(imageName: "park", title: "Serene Park View", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est..")
    ]
    var body: some View {
        CustomPageSlider(data:$items)
        { item in
            Image(String(item.imageName.wrappedValue))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 210)
        } titleContent: { item in
            VStack (alignment: .leading){
                HStack  {
                    Text(String(item.title.wrappedValue))
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    Spacer()

                }
                HStack{
                    Text(String(item.description.wrappedValue))
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 1)
                }
                
            }
            .safeAreaPadding(.horizontal, 6)
            .safeAreaPadding(.vertical, 10)
            .background(Color.gray.opacity(0.2))
        }
        .cornerRadius(8)
  .padding([.leading, .trailing], 16)
  .padding(.bottom, 10)
    }
}

#Preview {
    ContentView()
}


