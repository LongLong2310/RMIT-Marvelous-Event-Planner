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
// State variables to track various UI states.
struct LogInSignUpView: View {
    @EnvironmentObject private var authState: AuthState
    
    @State var showMainPage: Bool = false
    @State var isSignUp: Bool = false
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @State private var confirmPasswordInput: String = ""

    
    var body: some View {
        VStack {
            // Welcome text with styling
            Text("Welcome to\nRMEP")
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 4.5)
                .font(.system(size: 50))
                .bold()
                .padding()
                .background(
                    // Stylish background elements, including a gradient circle and small circles.
                    ZStack {
                        // Gradient circle
                        LinearGradient(
                            colors: [
                                .accentColor.opacity(0),
                                .accentColor
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
                        
                        // Small circles
                        Circle()
                            .strokeBorder(
                                Color.accentColor.opacity(0.3),
                                lineWidth: 3
                            )
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(
                                Color.accentColor.opacity(0.3),
                                lineWidth: 3
                            )
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                        
                    }
                )
            
            // Scrollable view for login and signup forms.
            ScrollView(.vertical, showsIndicators: false) {
                // Login forms
                VStack (spacing: 15) {
                    Text(isSignUp ? "Register" : "Login")
                        .bold()
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    // Custom text fields for email and password.
                    CustomTextField(
                        icon: "envelope",
                        title: "Email",
                        hint: "Email ID",
                        value: $emailInput,
                        showPassword: .constant(false)
                    )
                    .padding(.top, 15)
                    
                    CustomTextField(
                        icon: "lock",
                        title: "Password",
                        hint: "Password",
                        value: $passwordInput,
                        showPassword: $showPassword
                    )
                    .padding(.top, 10)
                    
                    //  Show confirm password field only if user is registering
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
                    
                    // "Forgot Password" button (visible only in login mode).
                    if !isSignUp {
                        Button {

                        } label: {
                            Text("Forgot password?")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("primary-button"))
                        }
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Login or Signup Button.
                    Button {
                        // call function authenticated from view model AuthState
                        if isSignUp{
                            signUp()
                        }
                        else{
                            signIn()
                        }
                    } label: {
                        Text(isSignUp ? "Sign Up" : "Login")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButton())
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    .padding(.top, 25)
                    // A VStackwith text and a button for toggling between login and signup modes.
                    // It displays either "Have an account?" or "Don't have an account?" based on the isSignUp state.
                    VStack (spacing: 10) {
                        HStack {
                            Text(isSignUp ? "Have an account?" : "Don't have an account?")
                            // Register User button
                            Button {
                                // Toggle the isSignUp state with animation when the button is pressed.
                                withAnimation {
                                    isSignUp.toggle()
                                }
                            } label: {
                                // The button label dynamically changes between "Login" and "Sign up."
                                Text(isSignUp ? "Login" : "Sign up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("primary-button"))
                            }
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(30)
            }
            .background()
            .cornerRadius(10)
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("primary-button"))
        
    }
    
    // Function to create custom text fields with optional secure input.
    @ViewBuilder
    func CustomTextField(
        icon: String,
        title: String,
        hint: String,
        value: Binding<String>,
        showPassword: Binding<Bool>
    ) -> some View {
        // Create a VStack to arrange the components vertically.
        VStack (alignment: .leading, spacing: 12) {
            // Label for the text field, displaying the title.
            Label {
                Text(title)
            } icon: {
                // Icon displayed alongside the title.
                Image(systemName: icon)
            }
            
            // Depending on the title (e.g., if it contains "Password") and showPassword state,
            // either show a SecureField (password) or TextField (non-password) input.
            if (title.contains("Password") && !showPassword.wrappedValue) {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            // Divider line below the text input.
            Divider()
        }
        // Overlay a button to toggle password visibility (visible only for password fields).
        .overlay(
            Group {
                if (title.contains("Password")) {
                    Button (
                        action: {
                            // Toggle the showPassword state to hide/show the password.
                            showPassword.wrappedValue.toggle()
                        },
                        label: {
                            // Display "Hide" when the password is shown, and "Show" when hidden.
                            Text(showPassword.wrappedValue ? "Hide" : "Show")
                                .foregroundColor(Color("primary-button"))
                        }
                    )
                    .offset(y: 9)
                }
            },
            alignment: .trailing
        )
    }
    
    func signIn(){
        Task {
            // TODO: Han - Add try catch and await for authenticated
            authState.signIn(email: emailInput, password: passwordInput)
        }
    }
    
    func signUp(){
        Task {
            // TODO: Han - Add try catch and await for authenticated
            authState.signUp(email: emailInput, password: passwordInput)
        }
    }
}

// Custom shape for rounded corners.
struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}

// Extension to get the screen's rectangle.
extension View {
    // get rectangle
    func getRect() -> CGRect{
        // CGRect contains locations and dimensions of a rectangle
        return UIScreen.main.bounds
    }
}

// Preview for development purposes.
struct LogInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpView()
    }
}
