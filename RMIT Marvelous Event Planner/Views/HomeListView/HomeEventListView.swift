/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Pham Trinh Hoang Long, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 12/09/2023
  Last modified: 14/09/2023
  Acknowledgement: https://stackoverflow.com/questions/72326887/removing-the-space-above-the-searchable-search-bar-in-navigation-view-in-swiftui
*/

import SwiftUI

struct HomeEventListView: View {
    @EnvironmentObject private var authState: AuthState
    @State private var searchText = ""
    @State private var didTap:Bool = false
    @State private var selectedEvent: Event?
    @State private var buttonColor: Color = Color.blue
    @State private var activeFilter = ""
    @State public var preselectedIndex: Int = 0
    @State private var isMajorFilterSetting: Bool = false
    @ObservedObject var eventVM: EventViewModel = EventViewModel()
    
    // Filtered events based on the search text
    var filteredEvents: [Event] {
        if searchText.isEmpty || eventVM.events.isEmpty{
            return eventVM.events
        } else {
            return eventVM.events.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                SearchBar(text: $searchText, placeholder: "Search")
                    .padding(.top)
                
                HStack{
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(lineWidth: 2)
                        .frame(width: 25, height: 25)
                        .cornerRadius(5.0)
                        .overlay {
                            Image(systemName: isMajorFilterSetting ? "checkmark" : "")
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isMajorFilterSetting.toggle()
                                authState.setisMajorFilterSetting(isMajorFilterSetting: isMajorFilterSetting)
                            }
                        }
                    Text("Filter By Major")
                }
                
                CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: OrganizerRole.allCases.map { $0.rawValue })
                    .padding(.leading)
                    .padding(.trailing)
                
                
                EventList(events: Binding(get: { filteredEvents }, set: { _ in }), listType: "Home Event")
            }
        }
        .onAppear(){
            self.eventVM.queryEventsHomePage()
        }
    }
}

    
struct HomeEventListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = Color("primary-button")
    let textColor = Color("text-color")
    @State var uiHeight = UIScreen.main.bounds.height
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                    Rectangle()
                        .fill(color)
                        .cornerRadius(10)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(preselectedIndex == index ? .white : textColor)
                )
            }
        }
        .frame(height: uiHeight * 0.04)
        .cornerRadius(10)
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}

enum Filter: String, CaseIterable {
    case any = "Any"
    case type1 = "Type 1"
    case type2 = "Type 2"
    case type3 = "Type 3"
}
    
