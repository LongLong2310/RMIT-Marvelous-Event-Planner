/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
  ID: s3877991, s3879366, s3877457, s3891710, s3750789
  Created  date: 08/09/2023
  Last modified: dd/09/2023
  Acknowledgement: None.
*/

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var authState: AuthState
    @Environment(\.dismiss) var dismiss
    @State var isEditEvent: Bool = false
    @State private var showingPopupAlert = false
    
    @StateObject var formViewModel: EventFormViewModel
    
    var body: some View {
        ZStack {
            // MARK: - Event details view
            VStack(spacing: 0) {
                // Image view
                Image(formViewModel.event.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.size.width, height: 250)
                
                // Information view
                ScrollView {
                    VStack(spacing: 10) {
                        // Event specs
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(formViewModel.event.name)
                                    .font(Font.custom("Poppins-SemiBold", size: 24))
                                Spacer()
                            }
                            
                            ListItem(icon: "clock.fill", content: "\(formViewModel.event.date) - \(formViewModel.event.time)", size: 18)
                            ListItem(icon: "mappin.and.ellipse", content: formViewModel.event.location, size: 18)
                            ListItem(icon: "person.3.fill", content: "\(123) participants", size: 18)
                        }
                        .padding(.top, 10)
                        
                        // Event description
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("About")
                                    .font(Font.custom("Poppins-Medium", size: 20))
                                Spacer()
                            }
                            Text(formViewModel.event.description)
                                .font(Font.custom("Poppins-Regular", size: 15))
                        }
                        .padding(.vertical, 10)
                        
                        // Event organizer
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Organizer")
                                    .font(Font.custom("Poppins-Medium", size: 20))
                                Spacer()
                            }
                            
                            HStack(spacing: 10) {
                                Image("sample-avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .clipped()
                                VStack(alignment: .leading) {
                                    Text("Username")
                                        .font(Font.custom("Poppins-Regular", size: 15))
                                    Text(formViewModel.event.organizerRole)
                                        .font(Font.custom("Poppins-Regular", size: 12))
                                }
                            }
                        }
                        .padding(.bottom, 60)
                    }
                    .padding(.horizontal, 20)
                }
                .background()
                .cornerRadius(10)
                .offset(y: -20)
            }
            
            // MARK: - User action on event
            VStack {
                // Back button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                                .font(Font.custom("Poppins-Regular", size: 18))
                        }
                    }
                    .buttonStyle(BackButton())
                    .shadow(radius: 1, x: 2.5, y: 2.5)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 20) {
                    if (authState.account!.id == formViewModel.event.ownerId){
                        HStack{
                            Button {
                                isEditEvent = true
                            } label: {
                                HStack {
                                    Image(systemName: "pencil")
                                        .rotationEffect(.degrees(-90))
                                    Text("Edit")
                                        .font(Font.custom("Poppins-Regular", size: 18))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(PrimaryButton())
                            
                            Button{
                                showingPopupAlert = true
                            }label:{
                                HStack{
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Log out")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(WarningButton())
                            .alert(isPresented: $showingPopupAlert) {
                                  Alert(title: Text("Are you sure to delete event?"), message: Text("This action is permanent."), primaryButton: .destructive(Text("Confirm"), action: {
                                    // Perform the action.
                                  }), secondaryButton: .cancel())
                            }
                        }
                        
                    }
                    else{
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                    .rotationEffect(.degrees(-90))
                                Text("Join")
                                    .font(Font.custom("Poppins-Regular", size: 18))
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButton())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color("opacity-background"))
            }
        }
        .sheet(isPresented: $isEditEvent) {
            EventForm(formViewModel: formViewModel)
        }
        .onChange(of: isEditEvent, perform: { newValue in
            formViewModel.fetchEvent()
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            formViewModel: EventFormViewModel(event: Event(
                id: "1",
                name: "Family reunion",
                description: "Anh em mot nha",
                dateTime: Date().formatted(
                    .dateTime
                        .day().month(.wide).year()
                        .hour().minute()),
                location: "Quang Binh",
                imageUrl: "sample-image",
                organizerRole: OrganizerRole.personal.rawValue,
                major: SchoolDepartment.SBM.rawValue))
        )
    }
}
