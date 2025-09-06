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

{ #category : #'look event sending' }
ToTransientStateStub >> applyOn: anElement fromQueue: aQueue [

	super applyOn: anElement fromQueue: aQueue.
	applyCount := applyCount + 1
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
