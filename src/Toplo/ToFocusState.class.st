Class {
	#name : #ToFocusState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToFocusState >> focused [

	^ focused
]

{ #category : #accessing }
ToFocusState >> focused: aValuable [

	focused := aValuable
]

{ #category : #accessing }
ToFocusState >> lookEventClass [

	^ self focused value
		  ifTrue: [ ToFocusedSkinEvent ]
		  ifFalse: [ ToUnfocusedSkinEvent ]
]
