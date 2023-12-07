Class {
	#name : 'ToTabPaneHeaderOnLeftBottom',
	#superclass : 'ToTabPaneHeaderOnLeft',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderOnLeftBottom >> applyOn: aTabPane [

	super applyOn: aTabPane.	
	aTabPane header tabRowContainer layout alignBottomCenter.
	aTabPane header endFiller size: 0 asPoint.
	aTabPane header startFiller matchParent

]
