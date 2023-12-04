Class {
	#name : 'ToTransientStateForTest',
	#superclass : 'ToTransientState',
	#instVars : [
		'applyCount'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToTransientStateForTest >> applyCount [

	^ applyCount
]

{ #category : 'initialization' }
ToTransientStateForTest >> initialize [ 

	super initialize.
	applyCount := 0
]

{ #category : 'look event sending' }
ToTransientStateForTest >> onAppliedOn: anElement [

	super onAppliedOn: anElement.
	applyCount := applyCount + 1
]
