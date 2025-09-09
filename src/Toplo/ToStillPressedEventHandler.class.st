Class {
	#name : #ToStillPressedEventHandler,
	#superclass : #ToEventGeneratorHandler,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToStillPressedEventHandler >> eventsToHandle [

	^ {
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  ToMouseUpOutsideEvent }
]

{ #category : #initialization }
ToStillPressedEventHandler >> initialize [ 

	super initialize.
	self initializeAsEventGeneratorHandler 
]

{ #category : #'event handling' }
ToStillPressedEventHandler >> mouseDownEvent: anEvent [

	self startEvent: anEvent
]

{ #category : #'event handling' }
ToStillPressedEventHandler >> mouseUpEvent: anEvent [

	self stopEvent: anEvent
]

{ #category : #'event handling' }
ToStillPressedEventHandler >> newRepeatedEvent [

	^ ToStillPressedEvent new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToStillPressedEventHandler >> newStartEvent [

	^ ToStartStillPressedEvent new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToStillPressedEventHandler >> newStopEvent [

	^ ToStopStillPressedEvent new
		  emitter: self;
		  yourself
]
