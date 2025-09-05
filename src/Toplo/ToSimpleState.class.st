Class {
	#name : #ToSimpleState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToSimpleState >> applyOn: anElement fromQueue: aQueue [

	| se |
	se := self skinEvent.
	se isConsumed ifTrue: [ ^ self ].
	anElement spaceDo: [ :sp | se fillFromTime: anElement space time ].
	anElement dispatchEvent: se.
	self onAppliedOn: anElement fromQueue: aQueue
]

{ #category : #'look event sending' }
ToSimpleState >> onAppliedOn: anElement fromQueue: aQueue [
]

{ #category : #accessing }
ToSimpleState >> skinEvent [ 

	^ self subclassResponsibility 
]
