Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement fromQueue: aQueue [

	| se |
	se := self skinEvent.
	se isConsumed ifTrue: [ ^ self ].
	anElement spaceDo: [ :sp | se fillFromTime: anElement space time ].
	anElement dispatchEvent: se.
	self onAppliedOn: anElement fromQueue: aQueue
]

{ #category : #testing }
ToElementState >> canBeEnqueuedFromElement: anElement inQueue: aStateQueue [

	^ aStateQueue hasInstallStateEnqueued
]

{ #category : #'look event sending' }
ToElementState >> onAppliedOn: anElement fromQueue: aQueue [

	self skinEvent consume

]

{ #category : #'look event sending' }
ToElementState >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	(self canBeEnqueuedFromElement: anElement inQueue: aStateQueue) ifTrue: [
		aStateQueue enqueueState: self for: anElement ]
]

{ #category : #accessing }
ToElementState >> skinEvent [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToElementState >> skinEventClass [

	^ self subclassResponsibility 
]
