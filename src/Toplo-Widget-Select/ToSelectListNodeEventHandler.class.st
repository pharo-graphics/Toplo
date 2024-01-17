Class {
	#name : #ToSelectListNodeEventHandler,
	#superclass : #ToNodeSelectionEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListNodeEventHandler >> eventsToHandle [

	^ super eventsToHandle, { BlPrimaryMouseDownEvent }
]

{ #category : #'mouse handlers' }
ToSelectListNodeEventHandler >> mouseDownEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToSelectListNodeEventHandler >> primaryMouseDownEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.
	infiniteElement selectionStrategy cherryPickIndex:
		target holder position
]

{ #category : #accessing }
ToSelectListNodeEventHandler >> select: anObject [

	select := anObject
]
