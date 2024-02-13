Class {
	#name : #ToSelectListNodeEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'mouse handlers' }
ToSelectListNodeEventHandler >> primaryMouseDownEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.
	infiniteElement selectionStrategy cherryPickIndex: target holder position
]

{ #category : #accessing }
ToSelectListNodeEventHandler >> select: anObject [

	select := anObject
]
