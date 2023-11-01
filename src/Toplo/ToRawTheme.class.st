Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#category : 'Toplo-Core-Skin'
}

{ #category : #accessing }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : #accessing }
ToRawTheme >> skinFor: anElement [

	^ anElement rawSkin
]
