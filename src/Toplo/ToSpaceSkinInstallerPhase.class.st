Class {
	#name : #ToSpaceSkinInstallerPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #testing }
ToSpaceSkinInstallerPhase >> isSettledIn: aSpace [
	"Return true if aSpace does not need a skin installation pass"

	^ aSpace phasesManager needSkinInstallPass not
		and: [ aSpace root hasNewSkinRequested not ]
]

{ #category : #accessing }
ToSpaceSkinInstallerPhase >> name [
	
	^ 'Skin installer phase'
]

{ #category : #actions }
ToSpaceSkinInstallerPhase >> runOn: aSpace [

	aSpace applyAllSkinInstallers
]
