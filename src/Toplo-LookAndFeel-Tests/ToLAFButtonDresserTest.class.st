"
A ToLAFButtonDresserTest is a test class for testing the behavior of ToLAFButtonDresser
"
Class {
	#name : #ToLAFButtonDresserTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Dressers'
}

{ #category : #tests }
ToLAFButtonDresserTest >> testDefaultSkin [ 

	| dresser |
	dresser := ToLAFButtonDresser new.
	self assert: dresser skin class equals: ToDefaultButtonSkin
]
