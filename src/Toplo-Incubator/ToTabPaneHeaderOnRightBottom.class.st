Class {
	#name : 'ToTabPaneHeaderOnRightBottom',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignBottomCenter
]
