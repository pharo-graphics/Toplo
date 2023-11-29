Class {
	#name : 'ToTabPaneHeaderOnTopLeft',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenterLeft

]
