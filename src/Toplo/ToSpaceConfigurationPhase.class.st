Class {
	#name : #ToSpaceConfigurationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceConfigurationPhase >> name [
	<return: #String>
	
	^ 'Inner configuration phase'
]

{ #category : #actions }
ToSpaceConfigurationPhase >> runOn: aSpace [

	aSpace applyAllToploConfigurations
]
