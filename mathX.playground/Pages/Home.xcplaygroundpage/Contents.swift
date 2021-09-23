//:#  mathX App
//: **Mathematics quiz app**
/*:
mathX is a simple quiz app made to improve your numerical addition.

## Introduction:
 
 * mathX is a simple quiz app that provides an excellent user interface backed by SwiftUI.
 * This app provides addition questions, you have to submit the maximum number of questions within a 1-minute time frame.
 * More the questions you solve better the score you get. Try your best to beat your High Score.
 * The app has been tested from every perspective, and almost every possible error has been fixed which leads to a flawless experience while using this app.

Enough talks, Let’s get started with the game itself…!!!😎

Click on the next button below

I hope this app will help you improve the speed of your numerical addition, and you will like it.
Thank you
 
Project by [Neeraj Rajeev Shetkar](https://www.linkedin.com/in/ineerajrajeev)
 
*/
//: [Next](@next)

//#-hidden-code
import SwiftUI
import PlaygroundSupport

// Main View
struct ContentView: View {
    let img = UIImage(named: "mathX")
    let wall = UIImage(named: "wall")
    var body: some View {
        ZStack {
            Image(uiImage: img!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
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

let view = ContentView()
let vc = UIHostingController(rootView: view)
PlaygroundPage.current.liveView = vc
//#-end-hidden-code
