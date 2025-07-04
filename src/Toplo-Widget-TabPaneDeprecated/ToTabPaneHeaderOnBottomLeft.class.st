Class {
	#name : #ToTabPaneHeaderOnBottomLeft,
	#superclass : #ToTabPaneHeaderOnBottom,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnBottomLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterLeft.
	aTabPane header startFiller size: 0 asPoint.
	aTabPane header endFiller matchParent


]
