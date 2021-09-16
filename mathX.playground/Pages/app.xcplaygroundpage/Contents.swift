//:#  mathX App
//: **Mathematics quiz app**
/*:
## Instructions:
 
 1) Click on the text field to get your keyboard ready to answer.
 2) Click on the yellow play button at the bottom to start the timer.
 3) When you find the perfect answer for the appearing question enter your answer in the text field and click on the submit button.
 4) You will find messages corresponding to your response
 5) You can use the clear button to clear the entered input
 6) Timer will turn its text color to red when you have less than 15 seconds left
 7) Also you can click on the Reset button to restart the timer
 
> Clicking on reset button will restart timer but also clear your earned score.

 
 I hope this app will help you improve the speed of your numerical addition, and you will like it.
 Thank you
 
WWDC Swift Student Challenge Project by [Neeraj Rajeev Shetkar](https://www.linkedin.com/in/ineerajrajeev)
*/
//: [Previous](@previous)
//#-hidden-code
import SwiftUI
import PlaygroundSupport

// Main View
struct ContentView: View {
    let wall = UIImage(named: "wall")
    var body: some View {
        ZStack {
            Home()
        }
        .padding()
        .background(Image(uiImage: wall!))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Main view contents
struct Home : View {
    @State var num1: Int = Int.random(in: 1...100) // First number
    @State var num2: Int = Int.random(in: 1...100) // Second number
    @State var ans: String = "" // User input
    @State var duration = 60 // Quiz duration
    @State var Score: Int = 0 // Score
    @State var HighScore: Int = 0 // Highest score since game has been started
    @State var start = false // Timer parameter
    @State var to : CGFloat = 0 // Amount of time passed
    @State var count = 0 // Timer
    @State var message = "" // Success message
    @State var error = "" // Error message
    let successMessages: [String] = ["Excellent", "Good job", "Great", "You seem to be a champion", "Keep it up", "Good", "Keep moving"] // List of success messages to be selected randomly
    let img = UIImage(named: "mathX") // Logo
    @State var stop: Bool = false
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        ZStack{
            VStack{
                // MARK: Logo
                HStack{
                    Image(uiImage: img!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                }
                Spacer()
                HStack {
                    VStack {
                        VStack {
                            HStack {
                                VStack{
                                    // MARK: Timer
                                    Text((60 - self.count) == 59 ? "Timer started" : "")
                                        .font(.system(size: 35, weight: .bold, design: .default))
                                        .foregroundColor(Color.red)
                                        .padding(.bottom)
                                    Text("\(60 - self.count)")
                                        .font(.system(size: 40, weight: .bold, design: .default))
                                        .foregroundColor((60 - self.count) < 15 ? Color.red : Color.blue)
                                    Text("Secs left")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .foregroundColor((60 - self.count) < 15 ? Color.red : Color.blue)
                                }
                            }.padding()
                            HStack {
                                // MARK: Timer progress bar
                                ProgressView(value: Double(self.count) / 60)
                            }
                        }.padding(.top)
                        // MARK: Score and High Score
                        HStack {
                            Text("Score = ")
                                .font(.system(size: 25, weight: .light, design: .default))
                            Text(String(Score))
                                .font(.system(size: 30, weight: .heavy, design: .default))
                            Spacer()
                            Text("High Score = ")
                                .font(.system(size: 25, weight: .light, design: .default))
                            Text(String(HighScore))
                                .font(.system(size: 30, weight: .heavy, design: .default))
                        }
                        // MARK: Question
                        HStack {
                            Text("\(num1) + \(num2) = ?")
                                .font(.system(size: 30, weight: .bold, design: .default))
                        }
                        // MARK: Proposed space for messages and errors
                        VStack {
                            HStack {
                                Text(message)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(Color.green)
                                Text(error)
                                    .font(.system(size: 20, weight: .heavy, design: .default))
                                    .foregroundColor(Color.red)
                            }
                            // MARK: User input
                            HStack {
                                TextField("Your answer", text: $ans)
                                    .font(.system(size: 23, weight: .light, design: .default))
                                    .frame(minWidth: 0, maxWidth: 400)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                            }.padding()
                        }
                        // MARK: Submit and Clear buttons
                        HStack {
                            Button(action: {
                                ans = ""
                            }) {
                                HStack {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                    Text("Clear")
                                        .fontWeight(.semibold)
                                        .font(.title)
                                }
                                .frame(minWidth: 0, maxWidth: 150)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                            }
                            Spacer()
                            Button(action: {
                                let ansCheck = Int(ans)
                                if (self.count != 0 && stop) {
                                    if ansCheck != nil {
                                        if (String(num1+num2) == ans && stop) {
                                            Score+=1
                                            num1 = Int.random(in: 1...100)
                                            num2 = Int.random(in: 1...100)
                                            ans = ""
                                            message = successMessages.randomElement()!
                                            error = ""
                                            if Score >= HighScore {
                                                HighScore = Score
                                            }
                                        }
                                        else {
                                            num1 = Int.random(in: 1...100)
                                            num2 = Int.random(in: 1...100)
                                            ans = ""
                                            message = ""
                                            error = "Incorrect answer !!!"
                                        }
                                    }
                                    else {
                                        ans = ""
                                        error = "Enter a valid input"
                                        message = ""
                                    }
                                }
                                else {
                                    error = "Click on the play button to start the timer"
                                    message = ""
                                }
                            }) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title)
                                    Text("Submit")
                                        .fontWeight(.semibold)
                                        .font(.title)
                                }
                                .frame(minWidth: 0, maxWidth: 150)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                            }
                        }
                    }
                }
                Spacer()
                    // MARK: Play button
                HStack(spacing: 20){
                    Button(action: {
                        if stop {
                            stop = false
                        }
                        else {
                            stop = true
                        }
                        if self.count == duration{
                            self.count = 0
                            withAnimation(.default){
                                self.to = 0
                            }
                        }
                        self.start.toggle()
                    }) {
                        HStack(spacing: 15){
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.black)
                            Text(self.start ? "Pause" : "Play")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: 150)
                        .padding()
                        .foregroundColor(.black)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                    }
                    // MARK: Reset Button
                    Button(action: {
                        self.count = 0
                        Score = 0
                        ans = ""
                        withAnimation(.default){
                            self.to = 0
                        }
                    }) {
                        HStack(spacing: 15){
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.white)
                            Text("Restart")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: 150)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                    }
                }
                .padding()
            }
            
        }
        .onReceive(self.time) { (_) in
            if self.start{
                if self.count != duration{
                    self.count += 1
                    withAnimation(.default){
                        self.to = CGFloat(self.count) / CGFloat(duration)
                    }
                }
                else{
                    self.start.toggle()
                    Score = 0
                    message = ""
                    error = ""
                    ans = ""
                    stop = false
                }
            }
            
        }.padding()
    }
}

let view = ContentView()
let vc = UIHostingController(rootView: view)
PlaygroundPage.current.liveView = vc
//#-end-hidden-code
