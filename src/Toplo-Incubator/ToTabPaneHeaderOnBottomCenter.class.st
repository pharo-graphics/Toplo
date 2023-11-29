Class {
	#name : 'ToTabPaneHeaderOnBottomCenter',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
