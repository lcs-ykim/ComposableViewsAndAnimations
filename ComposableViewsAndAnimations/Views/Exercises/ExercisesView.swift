//
//  ExercisesView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct ExercisesView: View {
    
    // MARK: Stored properties
    
    // Controls what example is showing in the pop-up sheet
    @State private var showExerciseOne = false
    @State private var showExerciseTwo = false
    @State private var showExerciseThree = false

    // MARK: Computed properties
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Group {
                    
                    // Exercise 1
                    Group {

                        Text("Exercise 1")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        Text("""
                            Use an implicit animation, and change text size, colour, and position when the text is tapped.
                            """)
                        
                        Button("Show Exercise 1") {
                            showExerciseOne = true
                        }
                        .sheet(isPresented: $showExerciseOne) {
                            ExerciseOneView(showThisView: $showExerciseOne)
                        }


                    }
                    
                    // Exercise 2
                    Group {

                        Text("Exercise 2")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        Text("""
                            Use an explicit animation, and animate only the change in colour, while other state changes (like position and text size) are not animated.
                            """)
                        
                        Button("Show Exercise 2") {
                            showExerciseTwo = true
                        }
                        .sheet(isPresented: $showExerciseTwo) {
                            ExerciseTwoView(showThisView: $showExerciseTwo)
                        }


                    }

                    // Exercise 3
                    Group {

                        Text("Exercise 3")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        Text("""
                            Freestyle. Create an animation of your choosing.
                            """)
                        
                        Button("Show Exercise 3") {
                            showExerciseThree = true
                        }
                        .sheet(isPresented: $showExerciseThree) {
                            ExerciseThreeView(showThisView: $showExerciseThree)
                        }


                    }

                }
                .padding(.bottom)

            }

        }
        .padding()
        .navigationTitle("Exercises")

    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExercisesView()
        }
    }
}
