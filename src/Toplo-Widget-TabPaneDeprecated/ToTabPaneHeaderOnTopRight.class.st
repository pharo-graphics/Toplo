Class {
	#name : #ToTabPaneHeaderOnTopRight,
	#superclass : #ToTabPaneHeaderOnTop,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnTopRight >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterRight.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller size: 0 asPoint.

]
