Class {
	#name : #ToSkinStateQueueForTest,
	#superclass : #ToSkinStateQueue,
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #'state application' }
ToSkinStateQueueForTest >> applyEnqueuedStatesFor: anElement [

	| atLeastOne |
	atLeastOne := nextStates notEmpty.
	super applyEnqueuedStatesFor: anElement.
	atLeastOne ifTrue: [
		anElement skinStateQueueApplied ]
]
