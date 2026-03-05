Class {
	#name : #ToResizeGripEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'gripTarget',
		'gripTargetHandler'
	],
	#category : #'Toplo-Layout-Support-Grips'
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

{ #category : #'event handling' }
ToResizeGripEventHandler >> elementAddedToParentEvent: anEvent [

	| grip |
	grip := anEvent currentTarget.
	gripTargetHandler := gripTarget
		                     addEventHandlerOn: BlElementExtentChangedEvent
		                     do: [ :evt | grip layoutGripTarget: gripTarget ]
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> elementRemovedFromParentEvent: anEvent [

	gripTarget removeEventHandler: gripTargetHandler.
	gripTargetHandler := nil
]

{ #category : #'api - accessing' }
ToResizeGripEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToParentEvent.
		  BlElementRemovedFromParentEvent.
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
