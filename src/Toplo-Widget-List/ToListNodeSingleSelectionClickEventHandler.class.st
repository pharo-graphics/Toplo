Class {
	#name : #ToListNodeSingleSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeSingleSelectionClickEventHandler >> listClickOnNodeEvent: anEvent [

	| listElement node mode |
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement primarySelectionMode.
	mode onClickEvent: anEvent onNode: node.
	anEvent consume
]
