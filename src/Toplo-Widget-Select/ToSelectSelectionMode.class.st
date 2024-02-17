Class {
	#name : #ToSelectSelectionMode,
	#superclass : #ToListSelectionMode,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'instance creation' }
ToSelectSelectionMode >> newSelecterIn: anElement [

	^ ToSelectSelectionModelSelecter new
]

{ #category : #accessing }
ToSelectSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToSelectSelectionMode >> onClickEvent: anEvent onNode: aNode [

	| index |
	super onClickEvent: anEvent onNode: aNode.
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
