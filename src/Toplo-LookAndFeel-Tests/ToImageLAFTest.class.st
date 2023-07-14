Class {
	#name : #ToImageLAFTest,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-ToWidgets'
}

{ #category : #test }
ToImageLAFTest >> testNotSupportedSkinType [

	| widget |
	widget := ToImage skinType: #notExistingTypeForCurrentTheme.
	self assert: widget skinType equals: #notExistingTypeForCurrentTheme.
	"If the theme does not support this skin type, a default skin is installed"
	self assert: widget skin class equals: (ToLAFImageDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
]

{ #category : #test }
ToImageLAFTest >> testSkinTypes [

	| widget |
	widget := ToImage new.
	self assert: widget skin isNil.
	
	widget := ToImage skinType: #default.
	self assert: widget skin class equals: (ToLAFImageDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
	
	widget := ToImage skinType: #primary.
	self assert: widget skin class ~= (ToLAFImageDresser new defaultSkin class).
	self assert: widget skin type equals: #primary.
	
	widget := ToImage skinType: nil.
	self assert: widget skin class equals: (ToLAFImageDresser new defaultSkin class).
	self assert: widget skin type equals: #default.
]
