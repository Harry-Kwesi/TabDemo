//
//  CustomPageSlider.swift
//  PinnedTabDemo
//
//  Created by Harry Kwesi De Graft on 14/12/23.
//

import SwiftUI



struct Item: Identifiable {
    private(set) var id: UUID = .init()
    var imageName: String
    var title: String
    var description: String
}

//Custom View
struct CustomPageSlider<Content: View, TitleContent: View, Item: RandomAccessCollection>: View where Item: MutableCollection, Item.Element: Identifiable{
    //Customize props
    var showsIndicator: ScrollIndicatorVisibility = .hidden
    var showPagingControl: Bool = true
    var pagingControlSpacing : CGFloat = 20
    var spacing : CGFloat = 10
    
    @Binding var data: Item
    @ViewBuilder var content:(Binding<Item.Element>) -> Content
    @ViewBuilder var titleContent:(Binding<Item.Element>) -> TitleContent
    
   
    @State private var activeId : UUID?
    
    var body: some View {
        VStack(spacing: pagingControlSpacing){
            ScrollView(.horizontal){
                HStack(spacing:spacing){
                    ForEach($data){ item in
                        VStack(spacing: 0){
                            content(item)
                            titleContent(item)
                        }
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            
          .scrollIndicators(showsIndicator)
          .scrollTargetBehavior(.viewAligned)
          .scrollPosition(id: $activeId)
        }
        
        HStack{
            if showPagingControl{
                PagingControl(numberOfPages: data.count, activePage: activePage){ value in
                    if let index = value as? Item.Index, data.indices.contains(index){
                        if let id = data[index].id as? UUID{
                            withAnimation(.snappy(duration: 0.35,extraBounce:0)){
                                activeId = id
                            }
                            
                        }
                    }
                }
            }
        }
       
        Spacer()
    }
  
    var activePage: Int {
        if let index = data.firstIndex(where: {$0.id as? UUID == activeId}) as? Int {
            return index
        }
        return 0
    }
}

// Paging Control
struct PagingControl:UIViewRepresentable{
    var numberOfPages : Int
    var activePage: Int
    var onPageChange: (Int) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onPageChange: onPageChange)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPage = activePage
        view.numberOfPages = numberOfPages
        view.backgroundStyle = .minimal
        view.currentPageIndicatorTintColor = UIColor(Color.red)
        view.pageIndicatorTintColor = UIColor.placeholderText
        
        view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        //Updating outside event changes
        uiView.numberOfPages = numberOfPages
        uiView.currentPage = activePage
    }
    
    class Coordinator: NSObject {
        var onPageChange:(Int) -> ()
        init(onPageChange: @escaping (Int) -> Void) {
            self.onPageChange = onPageChange
        }
        @objc
        func onPageUpdate(control: UIPageControl){
            onPageChange(control.currentPage)
        }
    }
}


#Preview {
    ContentView()
}

