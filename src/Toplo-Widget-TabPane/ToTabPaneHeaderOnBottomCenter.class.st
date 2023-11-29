Class {
	#name : 'ToTabPaneHeaderOnBottomCenter',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
