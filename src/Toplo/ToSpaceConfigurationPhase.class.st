Class {
	#name : #ToSpaceConfigurationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #testing }
ToSpaceConfigurationPhase >> isSettledIn: aSpace [
	"Return true if aSpace does not need a configuration pass"

	^ aSpace phasesManager needConfigurationPass not
]

{ #category : #accessing }
ToSpaceConfigurationPhase >> name [
	
	^ 'Configuration phase'
]

{ #category : #actions }
ToSpaceConfigurationPhase >> runOn: aSpace [

	aSpace applyAllWidgetConfigurations
]
