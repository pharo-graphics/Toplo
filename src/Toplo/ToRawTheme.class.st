Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#traits : 'TToStyleSheetTheme',
	#classTraits : 'TToStyleSheetTheme classTrait',
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
ToRawTheme >> defaultSkinFor: anElement [

	^ anElement skinManager defaultRawSkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #accessing }
ToRawTheme >> newRootSkin [

	^ ToSpaceRootSkin new
]

{ #category : #accessing }
ToRawTheme >> newSkinFor: anElement [

	| space |
	space := anElement space.
	^ (space notNil and: [ space root == anElement ])
		  ifTrue: [ self newRootSkin ]
		  ifFalse: [ anElement newRawSkin ]
]
