Class {
	#name : 'ToTabPaneHeaderOnLeftTop',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignTopCenter
]
