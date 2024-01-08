Class {
	#name : #ToCherryPickOnMouseDownEventHandler,
	#superclass : #ToListNodeSelectionEventHandler,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'api - accessing' }
ToCherryPickOnMouseDownEventHandler >> eventsToHandle [

	^ { BlPrimaryMouseDownEvent }
]

{ #category : #'mouse handlers' }
ToCherryPickOnMouseDownEventHandler >> mouseDownEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToCherryPickOnMouseDownEventHandler >> primaryMouseDownEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	infiniteElement := target holder infiniteElement.

	^ infiniteElement cherryPickIndex: target holder position
]
