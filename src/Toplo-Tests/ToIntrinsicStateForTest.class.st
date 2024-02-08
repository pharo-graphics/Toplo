Class {
	#name : #ToIntrinsicStateForTest,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'applyCount',
		'canBeEnqueued',
		'val'
	],
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #accessing }
ToIntrinsicStateForTest >> applyCount [

	^ applyCount
]

{ #category : #accessing }
ToIntrinsicStateForTest >> canBeEnqueued [

	^ canBeEnqueued
]

{ #category : #initialization }
ToIntrinsicStateForTest >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : #accessing }
ToIntrinsicStateForTest >> lookEventClass [

	^ ToIntrinsicLookEventForTest
]

{ #category : #'look event sending' }
ToIntrinsicStateForTest >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]

{ #category : #'look event sending' }
ToIntrinsicStateForTest >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	canBeEnqueued := self canBeEnqueuedFromElement: anElement inQueue: aStateQueue.
	super requestEnqueueFromElement: anElement inQueue: aStateQueue
]

{ #category : #accessing }
ToIntrinsicStateForTest >> val [

	^ val

]

{ #category : #accessing }
ToIntrinsicStateForTest >> val: anObject [

	val := anObject

]
