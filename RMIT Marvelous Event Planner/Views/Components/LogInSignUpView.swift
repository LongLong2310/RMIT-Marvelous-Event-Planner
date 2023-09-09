import SwiftUI

struct LogInSignUpView: View {
    @State var showMainPage: Bool = false
    @State var isSignUp: Bool = false
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @State private var confirmPasswordInput: String = ""

    
    var body: some View {
        
        VStack {
            // Welcome back text
            Text("Welcome to\nRMEP")
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 4.5)
                .font(.system(size: 50))
                .bold()
                .padding()
                .background(
                    ZStack {
                        
                        // gradient circle
                        LinearGradient(
                            colors: [
                                Color("Pink").opacity(0),
                                Color("Pink")
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                        
                        // small circles
                        Circle()
                            .strokeBorder(
                                Color("Pink").opacity(0.3),
                                lineWidth: 3
                            )
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(
                                Color("Pink").opacity(0.3),
                                lineWidth: 3
                            )
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                        
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                // Login forms
                VStack (spacing: 15) {
                    Text(isSignUp ? "Register" : "Login")
                        .bold()
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    // Custom Text Fields
                    // Email
                    CustomTextField(
                        icon: "envelope",
                        title: "Email",
                        hint: "Email ID",
                        value: $emailInput,
                        showPassword: .constant(false)
                    )
                    .padding(.top, 15)
                    
                    // Email
                    CustomTextField(
                        icon: "lock",
                        title: "Password",
                        hint: "Password",
                        value: $passwordInput,
                        showPassword: $showPassword
                    )
                    .padding(.top, 10)
                    
//                     Show confirm password field only if user is registering
                    if (isSignUp) {
                        CustomTextField(
                            icon: "lock",
                            title: "Confirm Password",
                            hint: "Confirm Password",
                            value: $confirmPasswordInput,
                            showPassword: $showConfirmPassword
                        )
                        .padding(.top, 10)
                    }
                    
                    // Forgot Password button
                    if !isSignUp {
                        Button {

                        } label: {
                            Text("Forgot password?")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Blue"))
                        }
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Login Button
                    Button {
                        isSignUp = false
                    } label: {
                        Text(isSignUp ? "Sign Up" : "Login")
                            .padding(.vertical, 20)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color("Blue"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                            
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    VStack (spacing: 10) {
                        HStack {
                            Text(isSignUp ? "Have an account?" : "Don't have an account?")
                                .foregroundColor(.black)
                            // Register User button
                            Button {
                                withAnimation {
                                    isSignUp.toggle()
                                }
                            } label: {
                                Text(isSignUp ? "Login" : "Sign up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Blue"))
                            }
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Blue"))
        
    }
    
    @ViewBuilder // helps create child views
    func CustomTextField(
        icon: String,
        title: String,
        hint: String,
        value: Binding<String>,
        showPassword: Binding<Bool>
    ) -> some View {
        
        VStack (alignment: .leading, spacing: 12) {
            Label {
                Text(title)
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if (title.contains("Password") && !showPassword.wrappedValue) {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // ShowPassword button
        .overlay(
            Group {
                if (title.contains("Password")) {
                    Button (
                        action: {
                            showPassword.wrappedValue.toggle()
                        },
                        label: {
                            Text(showPassword.wrappedValue ? "Hide" : "Show")
                                .foregroundColor(Color("Blue"))
                        }
                    )
                    .offset(y: 9)
                }
            },
            alignment: .trailing
        )
    }
}

struct CustomCorners: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}

extension View {
    // get rectangle
    func getRect() -> CGRect{
        // CGRect contains locations and dimensions of a rectangle
        return UIScreen.main.bounds
    }
}

struct LogInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpView()
    }
}
