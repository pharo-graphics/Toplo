Class {
	#name : 'ToTabPaneHeaderOnBottomRight',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenterRight
]
