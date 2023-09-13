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

struct UserImage: View {
    let image: Image
    
    var body: some View {
        ZStack{
            image
                .resizable()
                .frame( width: 200, height: 200)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 2)
                ).shadow(radius: 7)
                
        }

    }
}

struct UserImage_Previews: PreviewProvider {
    static var previews: some View {
        UserImage(image: Image("cat"))
    }
}
