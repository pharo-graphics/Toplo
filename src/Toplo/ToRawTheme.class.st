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
ToRawTheme >> defaultSkinFor: anElement [

	^ anElement defaultRawSkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #accessing }
ToRawTheme >> newRootSkin [

	^ ToSpaceRootSkin new
]

{ #category : #accessing }
ToRawTheme >> newSkinFor: anElement [

	| space skin |
	space := anElement space.
	skin := (space notNil and: [ space root == anElement ])
		        ifTrue: [ self newRootSkin ]
		        ifFalse: [ anElement newRawSkin ].
	skin forElement: anElement inTheme: self.
	^ skin
]
