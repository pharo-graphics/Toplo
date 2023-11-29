Class {
	#name : 'ToTabPaneHeaderOnRightCenter',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
