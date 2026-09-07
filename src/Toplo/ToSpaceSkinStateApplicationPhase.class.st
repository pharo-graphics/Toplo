Class {
	#name : #ToSpaceSkinStateApplicationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #testing }
ToSpaceSkinStateApplicationPhase >> isSettledIn: aSpace [
	"Return true if aSpace does not need a skin state application pass"

	^ aSpace phasesManager needSkinStateApplicationPass not
		and: [ aSpace root hasEnqueuedStates not ]
]

{ #category : #accessing }
ToSpaceSkinStateApplicationPhase >> name [
	
	^ 'Skin state phase'
]

{ #category : #actions }
ToSpaceSkinStateApplicationPhase >> runOn: aSpace [

	aSpace
		dispatchTimeEvent: ToSpaceSkinStateApplicationEndEvent
		during: [ aSpace applyAllEnqueuedStates ]
	
]
