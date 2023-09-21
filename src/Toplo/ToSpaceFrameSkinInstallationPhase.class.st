Class {
	#name : #ToSpaceFrameSkinInstallationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceFrameSkinInstallationPhase >> name [
	<return: #String>
	
	^ 'Skin installation'
]

{ #category : #actions }
ToSpaceFrameSkinInstallationPhase >> runOn: aSpace [

	aSpace checkSkinInstallation
]
