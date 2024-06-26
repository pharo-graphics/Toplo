Class {
	#name : #ToTransientState,
	#superclass : #ToElementState,
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

{ #category : #'look event sending' }
ToTransientState >> applyOn: anElement [

	skinEvent ifNil: [ Error signal: 'An explicit state must provide its own skin event instance' ].
	super applyOn: anElement
]

{ #category : #'look event sending' }
ToTransientState >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	skinEvent isConsumed ifTrue: [ self sourceEvent consume ].
	skinEvent := nil

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
