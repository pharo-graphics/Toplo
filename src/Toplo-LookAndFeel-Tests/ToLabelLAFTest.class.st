Class {
	#name : #ToLabelLAFTest,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-ToWidgets'
}

{ #category : #test }
ToLabelLAFTest >> testNotSupportedSkinType [

	| label |
	label := ToLabel skinType: #notExistingTypeForCurrentTheme.
	self assert: label skinType equals: #notExistingTypeForCurrentTheme.
	"If the theme does not support this skin type, a default skin is installed"
	self assert: label skin class equals: (ToLAFLabelDresser new defaultSkin class).
	self assert: label skin type equals: #default.
]

{ #category : #test }
ToLabelLAFTest >> testSkinTypes [

	| widget |
	widget := ToLabel new.
	self assert: widget skin isNil.
	
	widget := ToLabel skinType: #default.
	self assert: widget skin class equals: (ToLAFLabelDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
	
	widget := ToLabel skinType: #primary.
	self assert: widget skin class ~= (ToLAFLabelDresser new defaultSkin class).
	self assert: widget skin type equals: #primary.
	
	widget := ToLabel skinType: nil.
	self assert: widget skin class equals: (ToLAFLabelDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
]
