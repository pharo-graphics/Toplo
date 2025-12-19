Class {
	#name : #ToResizeGripEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'gripTarget'
	],
	#category : #'Toplo-Widget-InnerWindow-Support'
}

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEndEvent: anEvent [

	anEvent consume
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEvent: anEvent [

	anEvent currentTarget drag: gripTarget by: anEvent position - anEvent currentTarget initialDragPosition
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragStartEvent: anEvent [

	anEvent consume.
	anEvent currentTarget initialDragPosition: anEvent position.
	anEvent currentTarget initialPosition: gripTarget position.
	anEvent currentTarget initialExtent: gripTarget extent
]

{ #category : #'api - accessing' }
ToResizeGripEventHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEndEvent.
		  BlDragEvent }
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget [

	^ gripTarget
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget: anElement [

	gripTarget := anElement.
]
