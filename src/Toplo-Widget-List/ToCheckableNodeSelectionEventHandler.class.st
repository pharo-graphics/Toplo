Class {
	#name : #ToCheckableNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
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

	anEvent currentTarget item dispatchEvent: anEvent copy
]
