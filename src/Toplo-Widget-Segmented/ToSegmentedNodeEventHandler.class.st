Class {
	#name : #ToSegmentedNodeEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedNodeEventHandler >> clickEvent: anEvent [

	| target |
	" if the event dispatcher is a child of the node, then ignore it 
	because the event has already been handled by the child element "
	anEvent target = anEvent currentTarget ifFalse: [ ^self ].
	target := anEvent currentTarget.
	target content dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToSegmentedNodeEventHandler >> eventsToHandle [ 

	^ { BlClickEvent  }
]
