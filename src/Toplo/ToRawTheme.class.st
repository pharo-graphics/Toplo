Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#category : 'Toplo-Core-Theme'
}

{ #category : #accessing }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : #accessing }
ToRawTheme >> newSkinFor: anElement [

	^ anElement newRawSkin
]
