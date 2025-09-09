Class {
	#name : #ToMixedEventGeneratorHandler,
	#superclass : #ToEventGeneratorHandler,
	#instVars : [
		'startEventClass',
		'stopEventClass',
		'repeatedEventClass',
		'activateOnHovered',
		'activateOnPressed'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToMixedEventGeneratorHandler >> activateOnHovered: aBoolean [

	activateOnHovered := aBoolean

	
]

{ #category : #accessing }
ToMixedEventGeneratorHandler >> activateOnPressed: aBoolean [

	activateOnPressed := aBoolean
]

{ #category : #'api - accessing' }
ToMixedEventGeneratorHandler >> eventsToHandle [

	^ {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  ToMouseUpOutsideEvent }
]

{ #category : #initialization }
ToMixedEventGeneratorHandler >> initialize [ 

	super initialize.
	activateOnHovered := true.
	activateOnPressed := true.
	self initializeAsEventGeneratorHandler 
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> mouseDownEvent: anEvent [

	activateOnPressed ifFalse: [ ^ self ].

	startEventClass = ToStartStillHoveredEvent ifTrue: [ ^ self ].
	startEventClass := ToStartStillPressedEvent.
	stopEventClass := ToStopStillPressedEvent.
	repeatedEventClass := ToStillPressedEvent.

	self startEvent: anEvent
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> mouseEnterEvent: anEvent [

	activateOnHovered ifFalse: [ ^ self ].
	startEventClass := ToStartStillHoveredEvent.
	stopEventClass := ToStopStillHoveredEvent.
	repeatedEventClass := ToStillHoveredEvent.
	self startEvent: anEvent
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> mouseLeaveEvent: anEvent [

	activateOnHovered ifFalse: [ ^ self ].
	stopEventClass = ToStopStillHoveredEvent ifFalse: [ ^ self ].
	self stopEvent: anEvent.
	self resetEventClasses
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> mouseUpEvent: anEvent [

	activateOnPressed ifFalse: [ ^ self ].
	stopEventClass = ToStopStillPressedEvent ifFalse: [ ^ self ].
	self stopEvent: anEvent.
	self resetEventClasses
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> newRepeatedEvent [

	^ repeatedEventClass new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> newStartEvent [

	^ startEventClass new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> newStopEvent [

	^ stopEventClass new
		  emitter: self;
		  yourself
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> reset [

	self resetEventClasses
]

{ #category : #'event handling' }
ToMixedEventGeneratorHandler >> resetEventClasses [

	startEventClass := nil.
	stopEventClass := nil.
	repeatedEventClass := nil
]
