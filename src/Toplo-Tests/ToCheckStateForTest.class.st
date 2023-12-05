Class {
	#name : 'ToCheckStateForTest',
	#superclass : 'ToCheckState',
	#instVars : [
		'applyCount',
		'canBeEnqueued'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToCheckStateForTest >> applyCount [

	^ applyCount
]

{ #category : 'accessing' }
ToCheckStateForTest >> canBeEnqueued [

	^ canBeEnqueued
]

{ #category : 'initialization' }
ToCheckStateForTest >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : 'look event sending' }
ToCheckStateForTest >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]

{ #category : 'look event sending' }
ToCheckStateForTest >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	canBeEnqueued := self canBeEnqueuedFromElement: anElement inQueue: aStateQueue.
	super requestEnqueueFromElement: anElement inQueue: aStateQueue
]
