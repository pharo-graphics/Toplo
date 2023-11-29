Class {
	#name : 'ToTabPaneHeaderOnBottomRight',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterRight
]
