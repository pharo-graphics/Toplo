Class {
	#name : #ToTabPaneHeaderOnLeftCenter,
	#superclass : #ToTabPaneHeaderOnLeft,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnLeftCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller matchParent.

]
