Class {
	#name : #ToSpaceConfigurationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #accessing }
ToSpaceConfigurationPhase >> name [
	<return: #String>
	
	^ 'Configuration phase'
]

{ #category : #actions }
ToSpaceConfigurationPhase >> runOn: aSpace [

	aSpace applyAllWidgetConfigurations
]
