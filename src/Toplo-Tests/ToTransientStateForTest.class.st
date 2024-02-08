Class {
	#name : #ToTransientStateForTest,
	#superclass : #ToTransientState,
	#instVars : [
		'applyCount',
		'canBeEnqueued'
	],
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #accessing }
ToTransientStateForTest >> applyCount [

	^ applyCount
]

{ #category : #accessing }
ToTransientStateForTest >> canBeEnqueued [

	^ canBeEnqueued
]

{ #category : #initialization }
ToTransientStateForTest >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : #'look event sending' }
ToTransientStateForTest >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]

{ #category : #'look event sending' }
ToTransientStateForTest >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	canBeEnqueued := self canBeEnqueuedFromElement: anElement inQueue: aStateQueue.
	super requestEnqueueFromElement: anElement inQueue: aStateQueue
]
