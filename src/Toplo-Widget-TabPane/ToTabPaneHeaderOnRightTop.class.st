Class {
	#name : #ToTabPaneHeaderOnRightTop,
	#superclass : #ToTabPaneHeaderOnRight,
	#category : #'Toplo-Widget-TabPane-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnRightTop >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignTopCenter.
	aTabPane header startFiller size: 0 asPoint.
	aTabPane header endFiller matchParent.

]
