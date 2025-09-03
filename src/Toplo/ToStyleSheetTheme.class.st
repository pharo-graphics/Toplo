Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToStyleSheetTheme class >> canBeDefault [

	^ false
]

{ #category : #'skin creation' }
ToStyleSheetTheme >> newSkinFor: anElement [

	^ ToStyleSheetSkin new
]
