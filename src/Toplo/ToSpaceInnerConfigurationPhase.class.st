Class {
	#name : #ToSpaceInnerConfigurationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceInnerConfigurationPhase >> name [
	<return: #String>
	
	^ 'Inner configuration phase'
]

{ #category : #actions }
ToSpaceInnerConfigurationPhase >> runOn: aSpace [

	aSpace applyAllInnerConfigurations
]
