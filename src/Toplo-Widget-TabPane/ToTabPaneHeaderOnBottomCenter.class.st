Class {
	#name : #ToTabPaneHeaderOnBottomCenter,
	#superclass : #ToTabPaneHeaderOnBottom,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderOnBottomCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller matchParent.

]
