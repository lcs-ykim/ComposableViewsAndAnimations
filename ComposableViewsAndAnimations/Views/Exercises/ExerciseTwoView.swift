//
//  ExerciseTwoView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI
import UIKit

struct ExerciseTwoView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls what typeface the text is shown in
    @State private var typeFace: String = "Flying text"
    
    // Controls the size
    @State private var fontSize: CGFloat = 30.0
    
    // Controls the position
    @State private var offSet: CGFloat = -200.0
    
    // Controls the hue of the text
    @State private var hue: Color = .black
    
    // Controls the size of the circle
    @State private var scaleFactor: CGFloat = 1.0
    
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
                    .scaleEffect(scaleFactor)
                    .foregroundColor(hue)
                    .offset(x: 0, y: offSet)
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
                        
                                                
                        withAnimation() {
                            hue = Color(hue: Double.random(in: 1...360) / 360.0,
                                                   saturation: 0.8,
                                                   brightness: 0.8)
                        }
                        
                        
                    }
                    
                    .navigationTitle("Exercise 2")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Done") {
                                hideView()
                            }
                        }
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

struct ExerciseTwoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseTwoView(showThisView: .constant(true))
            ExerciseTwoView(showThisView: .constant(true))
        }
    }
}
