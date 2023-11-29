Class {
	#name : 'ToTabPaneHeaderOnLeftBottom',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.	
	aTabPane header layout alignBottomCenter
]
