Class {
	#name : 'ToTabPaneHeaderOnTopCenter',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter
]
