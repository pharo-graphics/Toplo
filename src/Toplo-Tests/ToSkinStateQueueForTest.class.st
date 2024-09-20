Class {
	#name : #ToSkinStateQueueForTest,
	#superclass : #ToSkinStateQueue,
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #hook }
ToSkinStateQueueForTest >> applyEnqueuedStatesIn: anElement [

	| atLeastOne |
	atLeastOne := nextStates notEmpty.
	super applyEnqueuedStatesIn: anElement.
	atLeastOne ifTrue: [
		anElement skinStateQueueApplied ]
]
