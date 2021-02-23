//
//  ExerciseOneView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI
import UIKit

struct ExerciseOneView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls what typeface the text is shown in
    @State private var typeFace: String = "Flying text"
    
    // Initialize a timer that will fire in one second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Whether to apply the animation
    @State private var useAnimation = false
    
    // Controls the size
    @State private var fontSize: CGFloat = 30.0
    
    // Controls the position
    @State private var offSet: CGFloat = -200.0
    
    // Controls the hue of the text
    @State private var hue: Color = .black
    
    // MARK: Computed properties
    
    // List all fonts available
    // NOTE: This is a very useful gist...
    //       https://gist.github.com/kristopherjohnson/c825cb97b1ad1fe0bc13d709986d0763
    private static let fontNames: [String] = {
        var names: [String] = []
        for familyName in UIFont.familyNames {
            names.append(contentsOf: UIFont.fontNames(forFamilyName: familyName))
        }
        return names.sorted()
    }()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text(typeFace)
                    .foregroundColor(hue)
                    .font(.custom(typeFace, size: fontSize))
                    .border(Color.blue, width: 1.0)
                    .offset(x: 0, y: offSet)
                    .onTapGesture {
                        if fontSize < 45.0 {
                            // Reduce the size of the circle by a tenth
                            fontSize += 5
                        } else {
                            // Make sure the button doesn't entirely disappear
                            fontSize = 30.0
                        }
                        
                        if offSet < 200.0 {
                            // Reduce the size of the circle by a tenth
                            offSet += 50.0
                        } else {
                            // Make sure the button doesn't entirely disappear
                            offSet = -200.0
                        }
                                                
                        hue = Color(hue: Double.random(in: 1...360) / 360.0,
                                    saturation: 0.8,
                                    brightness: 0.8)
                        
                        
                    }
                    
                    .animation(useAnimation ? .default : .none)

                    .navigationTitle("Exercise 1")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Done") {
                                hideView()
                            }
                        }
                    }
                    .onReceive(timer) { input in
                        
                        // Set the flag to enable animations
                        useAnimation = true
                        
                        // Stop the timer from continuing to fire
                        timer.upstream.connect().cancel()
                        
                    }
                
            }
            
        }
        
    }
    
    // MARK: Functions
    
    // Makes this view go away
    func hideView() {
        showThisView = false
    }
    
}

struct ExerciseOneView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseOneView(showThisView: .constant(true))
            ExerciseOneView(showThisView: .constant(true))
        }
    }
}
