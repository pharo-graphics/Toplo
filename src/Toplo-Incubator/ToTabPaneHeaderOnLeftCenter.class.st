Class {
	#name : 'ToTabPaneHeaderOnLeftCenter',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
