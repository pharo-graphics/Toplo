Class {
	#name : #ToLAFImageDresserTest,
	#superclass : #ToLookAndFeelTestCase,
	#category : #'Toplo-LookAndFeel-Tests-Core'
}

{ #category : #test }
ToLAFImageDresserTest >> testInitialize [

	| dresser |
	dresser := ToLAFImageDresser new.
	self assert: dresser skin class equals: ToDefaultImageSkin.
	self assert: dresser haveCompatibleSkin.
	self assert: dresser defaultToElementClass equals: ToImage.
]
