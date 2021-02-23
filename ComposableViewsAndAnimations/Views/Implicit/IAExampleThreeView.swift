//
//  IAExampleThreeView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI
import UIKit

struct IAExampleThreeView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls what typeface the text is shown in
    @State private var typeFace: String = "Helvetica-Neue"

    // Initialize a timer that will fire in one second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Whether to apply the animation
    @State private var useAnimation = false
    
    // MARK: Computed properties

    // List all fonts available
    // NOTE: This is a very useful gist...
    //    https://gist.github.com/kristopherjohnson/c825cb97b1ad1fe0bc13d709986d0763
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
                    .font(.custom(typeFace, size: 30.0))
                    .border(Color.blue, width: 1.0)
                    .onTapGesture {
                        typeFace = IAExampleThreeView.fontNames.randomElement()!
                    }
                // When useAnimation is true, the default animation effect will be used.
                // When useAnimation is false, there will be no animation.
//                    .animation(useAnimation ? .default : .none)
                    .animation(.default)

            }
            .navigationTitle("Example 3")
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
    
    // MARK: Functions
    
    // Makes this view go away
    func hideView() {
        showThisView = false
    }
    
}

struct IAExampleThreeView_Previews: PreviewProvider {
    static var previews: some View {
        IAExampleThreeView(showThisView: .constant(true))
    }
}
