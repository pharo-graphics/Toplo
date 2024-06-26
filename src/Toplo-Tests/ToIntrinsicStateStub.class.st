Class {
	#name : #ToIntrinsicStateStub,
	#superclass : #ToIntrinsicState,
	#instVars : [
		'applyCount',
		'canBeEnqueued',
		'val'
	],
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #accessing }
ToIntrinsicStateStub >> applyCount [

	^ applyCount
]

{ #category : #accessing }
ToIntrinsicStateStub >> canBeEnqueued [

	^ canBeEnqueued
]

{ #category : #initialization }
ToIntrinsicStateStub >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : #'look event sending' }
ToIntrinsicStateStub >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]

{ #category : #'look event sending' }
ToIntrinsicStateStub >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	canBeEnqueued := self canBeEnqueuedFromElement: anElement inQueue: aStateQueue.
	super requestEnqueueFromElement: anElement inQueue: aStateQueue
]

{ #category : #accessing }
ToIntrinsicStateStub >> skinEventClass [

	^ ToIntrinsicSkinEventStub
]

{ #category : #accessing }
ToIntrinsicStateStub >> val [

	^ val

]

{ #category : #accessing }
ToIntrinsicStateStub >> val: anObject [

	val := anObject

]
