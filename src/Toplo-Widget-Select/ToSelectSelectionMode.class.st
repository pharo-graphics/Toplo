Class {
	#name : #ToSelectSelectionMode,
	#superclass : #ToListSelectionMode,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSelectEventHandler }

]

{ #category : #accessing }
ToSelectSelectionMode >> onAddedNode: aNode [

	super onAddedNode: aNode.
	aNode select: self select
]

{ #category : #'event handling' }
ToSelectSelectionMode >> onClickOnNode: aNode event: anEvent [

	| index |
	index := aNode holder position.
	select mode onClickAtIndex: index
]

{ #category : #accessing }
ToSelectSelectionMode >> onRemovedNode: aNode [

	aNode select: nil.
	super onRemovedNode: aNode.

]

{ #category : #accessing }
ToSelectSelectionMode >> select [

	^ select
]

{ #category : #accessing }
ToSelectSelectionMode >> select: aSelect [

	select := aSelect
]
