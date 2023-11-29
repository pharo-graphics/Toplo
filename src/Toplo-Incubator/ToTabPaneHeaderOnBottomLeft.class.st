Class {
	#name : 'ToTabPaneHeaderOnBottomLeft',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenterLeft

]
