Class {
	#name : #ToStillPressedEventHandler,
	#superclass : #ToEventGeneratorHandler,
	#instVars : [
		'pickOutsideFilter'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToStillPressedEventHandler >> eventsToHandle [

	^ {
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  ToPickOutsideEvent }
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

	pickOutsideFilter := ToStillPressedPickOutsideEventFilter new
		                     element: target;
		                     yourself.		
	target space root addEventFilter: pickOutsideFilter.
	target enqueueTask: checker
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> mouseUpEvent: anEvent [

	self stopTaskIn: anEvent currentTarget
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newRepeatedEvent [

	^ ToStillPressedEvent new
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStartEvent [

	^ ToStartStillPressedEvent new
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStopEvent [

	^ ToStopStillPressedEvent new
]

{ #category : #'as yet unclassified' }
ToStillPressedEventHandler >> pickOutsideEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget
]

{ #category : #'as yet unclassified' }
ToStillPressedEventHandler >> stopTaskIn: target [

	pickOutsideFilter ifNotNil: [
		pickOutsideFilter isInstalled ifTrue: [
			target spaceDo: [ :sp |
				sp root removeEventFilter: pickOutsideFilter ] ].
		pickOutsideFilter := nil ].

	super stopTaskIn: target
]
