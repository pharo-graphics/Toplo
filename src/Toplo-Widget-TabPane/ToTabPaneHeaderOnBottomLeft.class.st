Class {
	#name : 'ToTabPaneHeaderOnBottomLeft',
	#superclass : 'ToTabPaneHeaderOnBottom',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnBottomLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header layout alignCenterLeft

]
