Class {
	#name : #ToSegmentedNodeSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #'event handling' }
ToSegmentedNodeSelectionEventHandler >> clickEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryClickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'api - accessing' }
ToSegmentedNodeSelectionEventHandler >> eventsToHandle [
	^ { BlPrimaryClickEvent }
]

{ #category : #'event handling' }
ToSegmentedNodeSelectionEventHandler >> primaryClickEvent: anEvent [

	anEvent currentTarget item dispatchEvent: anEvent copy
]
