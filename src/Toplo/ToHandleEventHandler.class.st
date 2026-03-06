Class {
	#name : #ToHandleEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #'event handling' }
ToHandleEventHandler >> dragEndEvent: anEvent [

	" don't consume the event to let the skin manage it "
	"anEvent consume"
]

{ #category : #'event handling' }
ToHandleEventHandler >> dragEvent: anEvent [

	| grip |
	anEvent consume.
	grip := anEvent currentTarget.
	grip isEnabled ifFalse: [ ^ self ].
	grip dragBy:
		anEvent position - anEvent currentTarget initialDragPosition
]

{ #category : #'event handling' }
ToHandleEventHandler >> dragStartEvent: anEvent [

	| grip |
	anEvent consume.
	grip := anEvent currentTarget.
	grip isEnabled ifFalse: [ ^ self ].	
	grip initialDragPosition: anEvent position.
	grip initialPosition: grip gripTarget position.
	grip initialExtent: grip gripTarget extent
]

{ #category : #'api - accessing' }
ToHandleEventHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEndEvent.
		  BlDragEvent.
		  BlMouseDownEvent }
]

{ #category : #'event handling' }
ToHandleEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget isEnabled ifFalse: [ ^ self ].
	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'event handling' }
ToHandleEventHandler >> primaryMouseDownEvent: anEvent [ 

	anEvent consume
]
