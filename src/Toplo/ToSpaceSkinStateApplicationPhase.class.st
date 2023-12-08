Class {
	#name : 'ToSpaceSkinStateApplicationPhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'accessing' }
ToSpaceSkinStateApplicationPhase >> name [
	<return: #String>
	
	^ 'Skin state phase'
]

{ #category : 'actions' }
ToSpaceSkinStateApplicationPhase >> runOn: aSpace [

	aSpace applyAllEnqueuedStates
]
