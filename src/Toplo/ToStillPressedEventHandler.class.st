Class {
	#name : #ToStillPressedEventHandler,
	#superclass : #ToEventGeneratorHandler,
	#instVars : [
		'mouseUpOutsideFilter'
	],
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
	delay := 0 milliSeconds.
	startDelay := 0 milliSeconds.
	time := BlTime real
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> mouseDownEvent: anEvent [

	| target  |
	checker ifNotNil: [ ^ self ].
	target := anEvent currentTarget.
	startTime := time now.
	checker := BlRepeatedTaskAction new
		           delay: delay asDuration;
		           action: [self taskActionFromEvent: anEvent in: target].

	mouseUpOutsideFilter := ToMouseUpOutsideEventFilter new
		                     element: target;
		                     yourself.		
	target space root addEventFilter: mouseUpOutsideFilter.
	target enqueueTask: checker
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> mouseUpEvent: anEvent [

	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> mouseUpOutsideEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newRepeatedEvent [

	^ ToStillPressedEvent new
		  emitter: self;
		  yourself
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStartEvent [

	^ ToStartStillPressedEvent new
		  emitter: self;
		  yourself
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStopEvent [

	^ ToStopStillPressedEvent new
		  emitter: self;
		  yourself
]

{ #category : #accessing }
ToStillPressedEventHandler >> stopTaskFromEvent: anEvent in: aTarget [

	mouseUpOutsideFilter ifNotNil: [
		mouseUpOutsideFilter isInstalled ifTrue: [
			aTarget spaceDo: [ :sp |
				sp root removeEventFilter: mouseUpOutsideFilter ] ].
		mouseUpOutsideFilter := nil ].

	super stopTaskFromEvent: anEvent in: aTarget
]

{ #category : #accessing }
ToStillPressedEventHandler >> stopTaskIn: target [

	mouseUpOutsideFilter ifNotNil: [
		mouseUpOutsideFilter isInstalled ifTrue: [
			target spaceDo: [ :sp |
				sp root removeEventFilter: mouseUpOutsideFilter ] ].
		mouseUpOutsideFilter := nil ].

	super stopTaskIn: target
]
