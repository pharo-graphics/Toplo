Class {
	#name : 'ToTabPaneHeaderOnTopCenter',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
