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
ToTransientState >> applyOn: anElement fromQueue: aQueue [

	skinEvent ifNil: [ Error signal: 'An explicit state must provide its own skin event instance' ].
	super applyOn: anElement fromQueue: aQueue
]

{ #category : #'look event sending' }
ToTransientState >> onAppliedOn: anElement fromQueue: aQueue [
	" A transient state is applied only one time"

	skinEvent isConsumed ifTrue: [ self sourceEvent consume ].
	" send to super last because the skin event is systematically consumed in super. "
	super onAppliedOn: anElement fromQueue: aQueue
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
ToTransientState >> skinEventClass [

	^ skinEvent class
]

{ #category : #accessing }
ToTransientState >> sourceEvent [

	^ skinEvent sourceEvent
]
