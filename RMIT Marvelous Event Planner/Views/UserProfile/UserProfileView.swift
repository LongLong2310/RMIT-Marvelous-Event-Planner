/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 3
 Author: Nguyen Quang Duy, Long Trinh Hoang Pham, Le Anh Quan, Pham Viet Hao, Tran Mach So Han
 ID: s3877991, s3879366, s3877457, s3891710, s3750789
 Created  date: 8/09/2023
 Last modified: 27/09/2023
 Acknowledgement:
    https://docs.google.com/presentation/d/1-QV6pqZBkdGgKGImB7t0izYk0OqzFdrf/edit#slide=id.g25839ad1222_0_435
*/

import SwiftUI

struct UserProfileView: View {
    
    let name : String
    let date : String
    let Major: String
    let Email: String
    
    @State var phase = 1
    @State private var fullname: String = ""
    @State private var birthday: String = ""
    @State private var major: String = ""
    
    func nextPhase(){
        if(phase < 3){
            phase += 1
        }
    }
    
    func prevPhase(){
        if(phase > 1){
            phase -= 1
        }
    }
    
    var body: some View {
        ZStack{
            if(phase == 1){
                VStack{
                    HStack{
                        Text("Profile")
                            .fontWeight(.heavy)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .offset(x:20)
                            .frame(height: getRect().height / 17.5)
                            
                        VStack{
                            Button{
                                nextPhase()
                            }label:{
                                Text("Edit")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                            }
                        }.offset(x:100)
                    }
                    UserImage(image: Image("cat"))
                        .offset(y:30)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20){
                            Spacer()
                            Text(name.uppercased())
                                .font(.system(size: 25))
                                .foregroundColor(Color("Blue"))
                                .fontWeight(.heavy)
                            UserRow(text: date)
                            UserRow(text: Major)
                            UserRow(text: Email)
                            Spacer()
                            VStack{
                                Button{
                                    
                                }label:{
                                    Text("Sign out")
                                }
                                
                            }.offset(y:100)
                            .foregroundColor(.red)
                               
                        }
                    } .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            // White background with rounded top corners.
                            Color.white
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                                .ignoresSafeArea()
                        )
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Blue"))
            }else if(phase == 2){
                ZStack{
                    VStack(spacing:30){
                        Text("Edit profile")
                            .fontWeight(.heavy)
                            .font(.system(size: 30))
                        Spacer()
                        Text("Full name")
                            .fontWeight(.heavy)
                            .font(.system(size: 25))
                        TextField(
                            fullname == "" ? "" : fullname,
                            text: $fullname
                        )
                        .padding(.all, 10)
                        .disableAutocorrection(true)
                        .frame(width: 380,height: 50)
                        .background(.gray)
                        .foregroundColor(.white)
                        
                        Text("Date of birth")
                            .fontWeight(.heavy)
                            .font(.system(size: 25))
                        TextField(
                            birthday == "" ? "" : birthday,
                            text: $birthday
                        )
                        .padding(.all, 10)
                        .disableAutocorrection(true)
                        .frame(width: 380,height: 50)
                        .background(.gray)
                        .foregroundColor(.white)
                        
                        Text("Current major")
                            .fontWeight(.heavy)
                            .font(.system(size: 25))
                        TextField(
                            major == "" ? "" : major,
                            text: $major
                        )
                        .padding(.all, 10)
                        .disableAutocorrection(true)
                        .frame(width: 380,height: 50)
                        .background(.gray)
                        .foregroundColor(.white)
                        
                        VStack{
                            Button{
                                prevPhase()
                            }label:{
                                Text("Confirm")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(name: "Pham Viet Hao", date: "04/04/2002", Major: "IT", Email: "s3891710@rmit.edu.vn")
    }
}
