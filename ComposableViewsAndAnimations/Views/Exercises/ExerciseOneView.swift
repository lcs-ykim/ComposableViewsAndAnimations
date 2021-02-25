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
    
    // Initialize a timer that will fire in one second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Whether to apply the animation
    @State private var useAnimation = false
    
    // Controls the position
    @State private var offSet: CGFloat = -200.0
    
    // Controls the hue of the circle
    @State private var hue: Color = .black
    
    // Controls the size of the circle
    @State private var scaleFactor: Double = 1.0
    
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
                
                Circle()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .foregroundColor(hue)
                    .offset(x: 0, y: offSet)
                    .scaleEffect(scaleFactor)
                    .onTapGesture {
                        
                        if offSet < 200.0 {

                            offSet += 50.0
                            
                        } else {

                            offSet = -200.0
                        }
                        
                        if scaleFactor < 3.0 {
                            scaleFactor += 0.25
                        } else {
                            scaleFactor = 1.0
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
