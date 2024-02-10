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

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToSelectSelectionMode >> onClickOnNode: aNode event: anEvent [

	| index |
	index := aNode holder position.
	select mode onClickAtIndex: index
]

{ #category : #accessing }
ToSelectSelectionMode >> select [

	^ select
]

{ #category : #accessing }
ToSelectSelectionMode >> select: aSelect [

	select := aSelect
]
