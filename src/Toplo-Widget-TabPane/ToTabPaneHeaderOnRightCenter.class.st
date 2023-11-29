Class {
	#name : 'ToTabPaneHeaderOnRightCenter',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenter
]
