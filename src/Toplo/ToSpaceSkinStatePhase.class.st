Class {
	#name : 'ToSpaceSkinStatePhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'accessing' }
ToSpaceSkinStatePhase >> name [
	<return: #String>
	
	^ 'Skin state phase'
]

{ #category : 'actions' }
ToSpaceSkinStatePhase >> runOn: aSpace [

	aSpace applySkinState
]
