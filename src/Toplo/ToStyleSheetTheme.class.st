Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToStyleSheetTheme class >> canBeDefault [

	^ false
]

{ #category : #accessing }
ToStyleSheetTheme >> newSkinFor: anElement [

	^ ToStyleSheetSkin new forElement: anElement inTheme: self
]
