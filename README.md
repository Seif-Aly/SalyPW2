# SalyPW2
Question: What issues prevent us from using storyboards in real projects?

1) Performance issues and big size with large storyboards.
2) Complexity and version control challenges.
3) Testing complexity.
4) Limited reuse and modularity.
5) Collaboration challenges in larger teams.
6) Accessibility complexity.


Question: What does the code on lines 25 and 29 do?

For line 25: When you add a view to a superview, the autoresizing mask constraints of view are translated into Auto Layout constraints by default. 
But when setting translatesAutoresizingMaskIntoConstraints to false indicates that we want to use Auto Layout constraints to control the view's layout
instead of the older autoresizing system.

For line 29: adds title view to main view, and itt means that the title view will be displayed within the bounds of the main view

Question: What is a safe area layout guide?

Safe Area Layout Guide is to defines a safe, unobstructed area on the screen that helps to position UI elements within this safe area using constraints by ensuring that it will be always visible and correctly positioned on different devices.
