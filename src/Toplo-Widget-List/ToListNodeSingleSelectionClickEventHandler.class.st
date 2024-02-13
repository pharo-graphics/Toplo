Class {
	#name : #ToListNodeSingleSelectionClickEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'events handling' }
ToListNodeSingleSelectionClickEventHandler >> clickEvent: anEvent [

	| listElement node holder mode |
	node := anEvent currentTarget.
	holder := node holder.	
	listElement := node holder listElement.
	mode := listElement selectionMode.

	mode onClickEvent: anEvent onNode: node.
	anEvent consumed: true
]
