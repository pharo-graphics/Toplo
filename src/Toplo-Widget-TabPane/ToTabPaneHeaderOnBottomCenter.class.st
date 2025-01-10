Class {
	#name : #ToTabPaneHeaderOnBottomCenter,
	#superclass : #ToTabPaneHeaderOnBottom,
	#category : #'Toplo-Widget-TabPane-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnBottomCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller matchParent.

]
