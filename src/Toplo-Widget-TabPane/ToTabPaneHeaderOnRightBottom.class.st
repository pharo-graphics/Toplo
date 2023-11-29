Class {
	#name : 'ToTabPaneHeaderOnRightBottom',
	#superclass : 'ToTabPaneHeaderOnRight',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnRightBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignBottomCenter
]
