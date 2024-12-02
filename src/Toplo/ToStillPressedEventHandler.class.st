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

	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newRepeatedEvent [

	^ ToStillPressedEvent new sourceHandler: self; yourself
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStartEvent [

	^ ToStartStillPressedEvent new sourceHandler: self; yourself
]

{ #category : #'instance creation' }
ToStillPressedEventHandler >> newStopEvent [

	^ ToStopStillPressedEvent new sourceHandler: self; yourself
]

{ #category : #'mouse handlers' }
ToStillPressedEventHandler >> pickOutsideEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #accessing }
ToStillPressedEventHandler >> stopTaskFromEvent: anEvent in: aTarget [

	pickOutsideFilter ifNotNil: [
		pickOutsideFilter isInstalled ifTrue: [
			aTarget spaceDo: [ :sp |
				sp root removeEventFilter: pickOutsideFilter ] ].
		pickOutsideFilter := nil ].

	super stopTaskFromEvent: anEvent in: aTarget
]

{ #category : #accessing }
ToStillPressedEventHandler >> stopTaskIn: target [

	pickOutsideFilter ifNotNil: [
		pickOutsideFilter isInstalled ifTrue: [
			target spaceDo: [ :sp |
				sp root removeEventFilter: pickOutsideFilter ] ].
		pickOutsideFilter := nil ].

	super stopTaskIn: target
]
