Class {
	#name : 'ToTabPaneHeaderOnTopRight',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterRight
]
