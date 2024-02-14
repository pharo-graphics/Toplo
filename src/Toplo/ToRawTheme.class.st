Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToRawTheme class >> canBeDefault [

	^ true
]

{ #category : #accessing }
ToRawTheme class >> label [

	^'Raw'
]

{ #category : #accessing }
ToRawTheme >> expectedSkinFor: anElement [

	^ anElement skinManager defaultRawSkin ifNil: [
		  super expectedSkinFor: anElement ]
]

{ #category : #accessing }
ToRawTheme >> newRootSkinInstance [

	^ ToSpaceRootSkin new
]

{ #category : #accessing }
ToRawTheme >> newSkinInstanceFor: anElement [

	| space |
	space := anElement space.
	^ (space notNil and: [ space root == anElement ])
		  ifTrue: [ self newRootSkinInstance ]
		  ifFalse: [ anElement newRawSkin ]
]
