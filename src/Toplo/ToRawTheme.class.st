Class {
	#name : 'ToRawTheme',
	#superclass : 'ToTheme',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'accessing' }
ToRawTheme >> name [

	^ #'RawTheme'
]

{ #category : 'accessing' }
ToRawTheme >> newRootSkinInstance [

	^ ToSpaceRootSkin new
]

{ #category : 'accessing' }
ToRawTheme >> newSkinInstanceFor: anElement [

	| space |
	space := anElement space.
	^ (space notNil and: [ space root == anElement ])
		  ifTrue: [ self newRootSkinInstance ]
		  ifFalse: [ anElement newRawSkin ]
]
