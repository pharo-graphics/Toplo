Class {
	#name : #ToTabPaneHeaderOnRightBottom,
	#superclass : #ToTabPaneHeaderOnRight,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #hook }
ToTabPaneHeaderOnRightBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.
	aTabPane header tabRowContainer layout alignBottomCenter.
	aTabPane header startFiller matchParent.
	aTabPane header endFiller size: 0 asPoint

]
