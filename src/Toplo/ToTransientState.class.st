Class {
	#name : #ToTransientState,
	#superclass : #ToSimpleState,
	#instVars : [
		'skinEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToTransientState class >> skinEvent: aSkinEvent [

	^ self new
		  skinEvent: aSkinEvent;
		  yourself
]

{ #category : #accessing }
ToTransientState >> skinEvent [

	^ skinEvent 
]

{ #category : #accessing }
ToTransientState >> skinEvent: aSkinEvent [

	skinEvent := aSkinEvent
]

{ #category : #accessing }
ToTransientState >> sourceEvent [

	^ self skinEvent sourceEvent
]
