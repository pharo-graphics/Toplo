Class {
	#name : #ToCheckableNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core-Item'
}

{ #category : #'event handling' }
ToCheckableNodeSelectionEventHandler >> clickEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryClickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'api - accessing' }
ToCheckableNodeSelectionEventHandler >> eventsToHandle [

	^ { BlPrimaryClickEvent }
]

{ #category : #'event handling' }
ToCheckableNodeSelectionEventHandler >> primaryClickEvent: anEvent [

	| node |
	node := anEvent currentTarget.
	node item dispatchEvent: anEvent copy
]
