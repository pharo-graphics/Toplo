Class {
	#name : 'ToTabPaneHeaderOnLeftTop',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignTopCenter
]
