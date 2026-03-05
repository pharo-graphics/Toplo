Class {
	#name : #ToResizeGripEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'gripTarget'
	],
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEndEvent: anEvent [

	" don't consume the event to let the skin manage it "
	"anEvent consume"
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragEvent: anEvent [

	anEvent consume.
	anEvent currentTarget isEnabled ifFalse: [ ^ self ].
	anEvent currentTarget
		drag: gripTarget
		by: anEvent position - anEvent currentTarget initialDragPosition.

]

{ #category : #'event handling' }
ToResizeGripEventHandler >> dragStartEvent: anEvent [

	anEvent consume.
	anEvent currentTarget isEnabled ifFalse: [ ^ self ].
	anEvent currentTarget initialDragPosition: anEvent position.
	anEvent currentTarget initialPosition: gripTarget position.
	anEvent currentTarget initialExtent: gripTarget extent
]

{ #category : #'api - accessing' }
ToResizeGripEventHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEndEvent.
		  BlDragEvent.
		  BlMouseDownEvent }
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget [

	^ gripTarget
]

{ #category : #accessing }
ToResizeGripEventHandler >> gripTarget: anElement [

	gripTarget := anElement.
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget isEnabled ifFalse: [ ^ self ].
	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'event handling' }
ToResizeGripEventHandler >> primaryMouseDownEvent: anEvent [ 

	anEvent consume
]
