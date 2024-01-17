Class {
	#name : #ToResizeGripEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'gripTarget'
	],
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEndEvent: anEvent [

	anEvent consumed: true.
	anEvent currentTarget mouseCursor: Cursor normal
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEvent: anEvent [

	anEvent currentTarget drag: gripTarget by: anEvent position - anEvent currentTarget initialDragPosition
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragStartEvent: anEvent [


	anEvent consumed: true.
	anEvent currentTarget initialDragPosition: anEvent position.
	anEvent currentTarget initialPosition: gripTarget position.
	anEvent currentTarget initialSize: gripTarget size
]

{ #category : #'api - accessing' }
ToResizeGripEventHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEndEvent.
		  BlDragEvent.
		  BlMouseDownEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget [

	^ gripTarget
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget: anElement [

	gripTarget := anElement.
]

{ #category : #'mouse handlers' }
ToResizeGripEventHandler >> hover: anElement [

	anElement mouseCursor: anElement resizeCursor.
	anElement border: anElement hoveredBorder.
	anElement background: anElement hoveredBackground
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> leave: anElement [

	anElement border: anElement initialBorder.
	anElement background: anElement initialBackground


]

{ #category : #'mouse handlers' }
ToResizeGripEventHandler >> mouseDownEvent: anEvent [


	anEvent consumed: true.
	self hover: anEvent currentTarget
]

{ #category : #'mouse handlers' }
ToResizeGripEventHandler >> mouseEnterEvent: anEvent [

	anEvent consumed: true.
	anEvent anyButtonPressed ifFalse: [
		self hover: anEvent currentTarget ]
]

{ #category : #'mouse handlers' }
ToResizeGripEventHandler >> mouseLeaveEvent: anEvent [

	anEvent consumed: true.
	self leave: anEvent currentTarget
]
