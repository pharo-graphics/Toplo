Class {
	#name : #ToTransientState,
	#superclass : #ToElementState,
	#instVars : [
		'lookEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToTransientState class >> lookEvent: aLookEvent [

	^ self new
		  lookEvent: aLookEvent;
		  yourself
]

{ #category : #'look event sending' }
ToTransientState >> applyOn: anElement [

	lookEvent ifNil: [ Error signal: 'An explicit state must provide its own look event instance' ].
	super applyOn: anElement
]

{ #category : #accessing }
ToTransientState >> lookEvent [

	^ lookEvent 
]

{ #category : #accessing }
ToTransientState >> lookEvent: aLookEvent [

	lookEvent := aLookEvent
]

{ #category : #'look event sending' }
ToTransientState >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	lookEvent isConsumed ifTrue: [ self sourceEvent consume ].
	lookEvent := nil

]

{ #category : #accessing }
ToTransientState >> sourceEvent [

	^ self lookEvent sourceEvent
]
