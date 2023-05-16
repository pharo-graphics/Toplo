"
A ToLAFLabelDresserTest is a test class for testing the behavior of ToLAFLabelDresser
"
Class {
	#name : #ToLAFLabelDresserTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #test }
ToLAFLabelDresserTest >> testInitialize [

	| dresser |
	dresser := ToLAFLabelDresser new.
	self assert: dresser skin class equals: ToDefaultLabelSkin.
	self assert: dresser haveCompatibleSkin.
	self assert: dresser defaultToElementClass equals: ToLabel.
]
