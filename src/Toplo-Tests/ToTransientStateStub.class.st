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
ToTransientStateStub >> onAppliedOn: anElement fromQueue: aQueue [

	super onAppliedOn: anElement fromQueue: aQueue.
	applyCount := applyCount + 1
]
