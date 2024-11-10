Class {
	#name : #ToStillPressedEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'checker',
		'delay',
		'pickOutsideFilter',
		'time',
		'startDelay',
		'startTime',
		'startEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToStillPressedEventHandler >> delay: aDuration [

	delay := aDuration
]

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

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget 
]

{ #category : #'as yet unclassified' }
ToStillPressedEventHandler >> pickOutsideEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget
]

{ #category : #accessing }
ToStillPressedEventHandler >> startDelay: aDuration [

	startDelay := aDuration
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> stopTaskIn: target [

	pickOutsideFilter ifNotNil: [
		pickOutsideFilter isInstalled ifTrue: [
			target spaceDo: [ :sp |
				sp root removeEventFilter: pickOutsideFilter ] ].
		pickOutsideFilter := nil ].

	startEvent := nil.
	checker ifNil: [ ^ self ].
	checker stop.
	target dequeueTask: checker.
	checker := nil.
	target dispatchEvent: ToStopStillPressedEvent new
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> taskActionFromEvent: anEvent in: aTarget [

	| evt now |
	now := time now.
	now >= (startTime + startDelay) ifFalse: [ ^ self ].
	evt := startEvent
		       ifNil: [
			       startEvent := ToStartStillPressedEvent new
				                     modifiers: anEvent modifiers;
				                     yourself ]
		       ifNotNil: [
			       ToStillPressedEvent new
				       modifiers: anEvent modifiers;
				       yourself ].
	aTarget dispatchEvent: evt.
	evt isConsumed ifTrue: [ self stopTaskIn: aTarget ]
]
