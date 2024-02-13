Class {
	#name : #ToTabPaneHeaderOnLeftTop,
	#superclass : #ToTabPaneHeaderOnLeft,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderOnLeftTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignTopCenter.
	aTabPane header startFiller size: 0 asPoint.
	aTabPane header endFiller matchParent.

]
