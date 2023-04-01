"
A ToLAFLabelDresserTest is a test class for testing the behavior of ToLAFLabelDresser
"
Class {
	#name : #ToLAFLabelDresserTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Dressers'
}

{ #category : #test }
ToLAFLabelDresserTest >> testDefaultSkin [

	| dresser |
	dresser := ToLAFLabelDresser new.
	self assert: dresser skin class equals: ToDefaultLabelSkin
]
