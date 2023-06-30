Class {
	#name : #ToLAFRadioButtonDresserTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #test }
ToLAFRadioButtonDresserTest >> testInitialize [

	| dresser |
	dresser := ToLAFRadioButtonDresser new.
	self assert: dresser skin class equals: ToDefaultRadioButtonSkin.
	self assert: dresser haveCompatibleSkin.
	self assert: dresser defaultToElementClass equals: ToRadioButton.
]
