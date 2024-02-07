Class {
	#name : #ToListNodeSingleSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'mouse handlers' }
ToListNodeSingleSelectionClickEventHandler >> listClickOnNodeEvent: anEvent [

	anEvent listElement selectionMode
		onClickOnNode: anEvent currentTarget
		event: anEvent.
	anEvent consumed: true
]
