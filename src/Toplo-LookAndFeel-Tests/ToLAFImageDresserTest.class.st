Class {
	#name : #ToLAFImageDresserTest,
	#superclass : #TestCase,
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
