Class {
	#name : #ToListNodeSingleSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'mouse handlers' }
ToListNodeSingleSelectionClickEventHandler >> listClickOnNodeEvent: anEvent [

	anEvent listElement selectionManager
		onClickOnNode: anEvent currentTarget
		event: anEvent sourceEvent.
	anEvent consumed: true
]
