Class {
	#name : #ToFocusState,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'focusedValuable'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToFocusState >> focusedValuable [

	^ focusedValuable
]

{ #category : #accessing }
ToFocusState >> focusedValuable: aValuable [

	focusedValuable := aValuable
]

{ #category : #accessing }
ToFocusState >> lookEventClass [

	^ self focusedValuable value
		  ifTrue: [ ToFocusedLookEvent ]
		  ifFalse: [ ToUnfocusedLookEvent ]
]
