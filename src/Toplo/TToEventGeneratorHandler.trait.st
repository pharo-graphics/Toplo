Trait {
	#name : #TToEventGeneratorHandler,
	#instVars : [
		'checker',
		'delay',
		'time',
		'startDelay',
		'startTime',
		'startEvent',
		'mouseUpOutsideFilter'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> delay: aDuration [

	delay := aDuration
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> initializeAsEventGeneratorHandler [

	delay := 0 milliSeconds.
	startDelay := 0 milliSeconds.
	time := BlTime real
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> mouseUpOutsideEvent: anEvent [

	anEvent emitter = mouseUpOutsideFilter ifFalse: [ ^ self ].
	self stopEvent: anEvent
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> startDelay [

	^ startDelay
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> startDelay: aDuration [

	startDelay := aDuration
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> startEvent: anEvent [

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

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> stopEvent: anEvent [

	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> stopTaskFromEvent: anEvent in: aTarget [

	mouseUpOutsideFilter ifNotNil: [
		mouseUpOutsideFilter isInstalled ifTrue: [
			aTarget spaceDo: [ :sp |
				sp root removeEventFilter: mouseUpOutsideFilter ] ].
		mouseUpOutsideFilter := nil ].

	checker ifNotNil: [
		checker stop.
		aTarget dequeueTask: checker.
		checker := nil ].
	startEvent ifNil: [ ^ self ].
	startEvent := nil.
	aTarget dispatchEvent: (self newStopEvent
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> taskActionFromEvent: anEvent in: aTarget [

	| evt now |
	now := time now.
	now >= (startTime + startDelay) ifFalse: [ ^ self ].
	evt := startEvent
		       ifNil: [
			       startEvent := self newStartEvent
				                     sourceEvent: anEvent copy;
				                     yourself ]
		       ifNotNil: [
			       self newRepeatedEvent 
				       sourceEvent: anEvent copy;
				       yourself ].
	aTarget dispatchEvent: evt.
	evt isConsumed ifTrue: [ self stopTaskFromEvent: anEvent in: aTarget ]
]
