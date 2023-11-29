Class {
	#name : 'ToTabPaneHeaderOnTopRight',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenterRight
]
