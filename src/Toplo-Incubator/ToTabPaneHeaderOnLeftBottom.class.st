Class {
	#name : 'ToTabPaneHeaderOnLeftBottom',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.	
	aTabPane header layout alignBottomCenter
]
