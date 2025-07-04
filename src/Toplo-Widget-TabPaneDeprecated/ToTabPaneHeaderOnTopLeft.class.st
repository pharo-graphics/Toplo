Class {
	#name : #ToTabPaneHeaderOnTopLeft,
	#superclass : #ToTabPaneHeaderOnTop,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnTopLeft >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenterLeft.
	aTabPane header startFiller size: 0 asPoint.
	aTabPane header endFiller matchParent


]
