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

struct SplashScreenView: View {
    @State var isActive : Bool = false
    //starting size and opacity
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        //Change view when true
        if isActive {
            ContentView()
        } else {
            //display the view
            ZStack {
                Color("primary-button")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("rmit-logo").resizable().scaledToFit().frame(width:300)
                        .foregroundColor(.red)
                    Spacer()
                    VStack{
                        LottieView(loopMode: .loop).frame(width: 250,height: 250)
                      
                        Text("RMEP")
                            .font(Font.custom("Baskerville-Bold", size: 80))
                            .foregroundColor(.accentColor)
                        Text("RMIT Marvelous Event Planner")
                            .font(Font.custom("Baskerville-Bold", size: 20))
                            .foregroundColor(.white)
                        
                    }
                 Spacer()
                    
                    Text("from")
                        .font(Font.custom("Baskerville-Bold", size: 20))
                        .foregroundColor(.white)
                    
                    Text("IOS Noobs")
                        .font(Font.custom("Baskerville-Bold", size: 30))
                        .foregroundColor(.accentColor)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    //animation
                    withAnimation(.easeIn(duration: 1.2)) {
                        //turn to true size and opacity after animation
                        self.size = 1
                        self.opacity = 1.00
                   }
                    
                }
            }
            .onAppear {
                //dissapear after 2 second by setting isActive to true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
