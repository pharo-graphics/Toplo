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
	mode selectOnMouseDown ifTrue: [ ^ self ].
	mode onClickEvent: anEvent onNode: node.
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
ToListNodeSingleSelectionClickEventHandler >> primaryMouseDownEvent: anEvent [

	| node listElement mode |
	super primaryMouseDownEvent: anEvent.
	node := anEvent currentTarget.
	node := anEvent currentTarget.
	listElement := node holder listElement.
	mode := listElement selectionMode.
	mode selectOnMouseDown ifFalse: [ ^ self ].
	mode onClickEvent: anEvent onNode: node.
	anEvent consumed: true


]
