Class {
	#name : 'ToTabPaneHeaderOnLeftCenter',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
