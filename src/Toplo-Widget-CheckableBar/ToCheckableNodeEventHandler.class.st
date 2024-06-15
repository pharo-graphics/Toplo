Class {
	#name : #ToCheckableNodeEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'event handling' }
ToCheckableNodeEventHandler >> clickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target content dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToCheckableNodeEventHandler >> eventsToHandle [ 

	^ { BlClickEvent  }
]
