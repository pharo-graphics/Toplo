Class {
	#name : #ToTransientStateStub,
	#superclass : #ToTransientState,
	#instVars : [
		'applyCount',
		'canBeEnqueued'
	],
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #accessing }
ToTransientStateStub >> applyCount [

	^ applyCount
]

{ #category : #accessing }
ToTransientStateStub >> canBeEnqueued [

	^ canBeEnqueued
]

{ #category : #initialization }
ToTransientStateStub >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : #'look event sending' }
ToTransientStateStub >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]

{ #category : #'look event sending' }
ToTransientStateStub >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	canBeEnqueued := self canBeEnqueuedFromElement: anElement inQueue: aStateQueue.
	super requestEnqueueFromElement: anElement inQueue: aStateQueue
]
