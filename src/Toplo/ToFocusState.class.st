Class {
	#name : #ToFocusState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToFocusState >> applyOn: anElement [

	anElement focused: focused.
	super applyOn: anElement
]

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
		  ifTrue: [ ToFocusedLookEvent ]
		  ifFalse: [ ToUnfocusedLookEvent ]
]
