Class {
	#name : 'ToTabPaneHeaderOnTopLeft',
	#superclass : 'ToTabPaneHeaderOnTop',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnTopLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterLeft

]
