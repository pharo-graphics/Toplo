Class {
	#name : #ToTabPaneHeaderOnRightCenter,
	#superclass : #ToTabPaneHeaderOnRight,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderOnRightCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller matchParent.

]
