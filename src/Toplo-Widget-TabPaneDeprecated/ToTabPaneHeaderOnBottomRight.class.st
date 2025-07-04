Class {
	#name : #ToTabPaneHeaderOnBottomRight,
	#superclass : #ToTabPaneHeaderOnBottom,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnBottomRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterRight.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller size: 0 asPoint.

]
