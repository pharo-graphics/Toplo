Class {
	#name : #ToTabPaneHeaderOnTopCenter,
	#superclass : #ToTabPaneHeaderOnTop,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnTopCenter >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller matchParent.
	
]
