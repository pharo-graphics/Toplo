Class {
	#name : 'ToTabPaneHeaderOnRightTop',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignTopCenter
]
