Class {
	#name : 'ToTabPaneHeaderOnRightTop',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignTopCenter
]
