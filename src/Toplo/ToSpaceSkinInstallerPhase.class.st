Class {
	#name : #ToSpaceSkinInstallerPhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceSkinInstallerPhase >> name [
	<return: #String>
	
	^ 'Skin installer phase'
]

{ #category : #actions }
ToSpaceSkinInstallerPhase >> runOn: aSpace [

	aSpace applyAllSkinInstallers
]
