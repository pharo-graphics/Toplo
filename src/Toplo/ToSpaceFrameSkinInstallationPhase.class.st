Class {
	#name : #ToSpaceFrameSkinInstallationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Space - Frame'
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
