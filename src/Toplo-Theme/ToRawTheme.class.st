Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Theme-Core'
}

{ #category : #accessing }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : #accessing }
ToRawTheme >> skinBuilder [

	^ ToRawSkinBuilder new
]
