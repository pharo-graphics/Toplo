Class {
	#name : #ToSpaceSkinStatePhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceSkinStatePhase >> name [
	<return: #String>
	
	^ 'Skin state phase'
]

{ #category : #actions }
ToSpaceSkinStatePhase >> runOn: aSpace [

	aSpace applyAllStyles
]
