Class {
	#name : #ToButtonLAFTest,
	#superclass : #TestCase,
	#category : #'Toplo-LookAndFeel-Tests-ToWidgets'
}

{ #category : #test }
ToButtonLAFTest >> testNotSupportedSkinType [

	| button |
	button := ToButton skinType: #notExistingTypeForCurrentTheme.
	self assert: button skinType equals: #notExistingTypeForCurrentTheme.
	"If the theme does not support this skin type, a default skin is installed"
	self assert: button skin class equals: (ToLAFButtonDresser new defaultSkin class).
	self assert: button skin type equals: #default.
]

{ #category : #test }
ToButtonLAFTest >> testSkinTypes [

	| button |
	button := ToButton new.
	self assert: button skin isNil.
	
	button := ToButton skinType: #default.
	self assert: button skin class equals: (ToLAFButtonDresser new defaultSkin class).
	self assert: button skin type equals: #default.
	
	button := ToButton skinType: #primary.
	self assert: button skin class ~= (ToLAFButtonDresser new defaultSkin class).
	self assert: button skin type equals: #primary.
	
	button := ToButton skinType: nil.
	self assert: button skin class equals: (ToLAFButtonDresser new defaultSkin class).
	self assert: button skin type equals: #default.
]
