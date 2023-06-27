Class {
	#name : #ToRadioButtonLAFTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-ToWidgets'
}

{ #category : #test }
ToRadioButtonLAFTest >> testNotSupportedSkinType [

	| label |
	label := ToRadioButton skinType: #notExistingTypeForCurrentTheme.
	self assert: label skinType equals: #notExistingTypeForCurrentTheme.
	"If the theme does not support this skin type, a default skin is installed"
	self assert: label skin class equals: (ToLAFRadioButtonDresser new defaultSkin class).
	self assert: label skin type equals: #default.
]

{ #category : #test }
ToRadioButtonLAFTest >> testSkinTypes [

	| widget |
	widget := ToRadioButton new.
	self assert: widget skin isNil.
	
	widget := ToRadioButton skinType: #default.
	self assert: widget skin class equals: (ToLAFRadioButtonDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
	
	widget := ToRadioButton skinType: nil.
	self assert: widget skin class equals: (ToLAFRadioButtonDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
]
