Class {
	#name : #ToStillHoveredEventHandler,
	#superclass : #ToEventGeneratorHandler,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToStillHoveredEventHandler >> eventsToHandle [

	^ {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #initialization }
ToStillHoveredEventHandler >> initialize [ 

	super initialize.
	self initializeAsEventGeneratorHandler 
]

{ #category : #'event handling' }
ToStillHoveredEventHandler >> mouseEnterEvent: anEvent [

	self startEvent: anEvent
]

{ #category : #'event handling' }
ToStillHoveredEventHandler >> mouseLeaveEvent: anEvent [

	self stopEvent: anEvent
]

{ #category : #'event handling' }
ToStillHoveredEventHandler >> newRepeatedEvent [

	^ ToStillHoveredEvent new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToStillHoveredEventHandler >> newStartEvent [

	^ ToStartStillHoveredEvent new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToStillHoveredEventHandler >> newStopEvent [

	^ ToStopStillHoveredEvent new
		  emitter: self;
		  yourself
]
