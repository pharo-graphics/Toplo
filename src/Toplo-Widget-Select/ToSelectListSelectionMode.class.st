Class {
	#name : #ToSelectListSelectionMode,
	#superclass : #ToListSelectionMode,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'instance creation' }
ToSelectListSelectionMode >> newSelecterIn: anElement [

	^ ToSelectSelectionModelSelecter new
]

{ #category : #accessing }
ToSelectListSelectionMode >> nodeEventHandlerClasses [ 

	^ { ToListNodeSingleSelectionClickEventHandler }

]

{ #category : #'event handling' }
ToSelectListSelectionMode >> onClickEvent: anEvent onNode: aNode [

	| index |
	super onClickEvent: anEvent onNode: aNode.
	index := aNode holder position.
	select mode onClickAtIndex: index
]

{ #category : #accessing }
ToSelectListSelectionMode >> select [

	^ select
]

{ #category : #accessing }
ToSelectListSelectionMode >> select: aSelect [

	select := aSelect
]
