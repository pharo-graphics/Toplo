Trait {
	#name : #TToEventGeneratorHandler,
	#instVars : [
		'checker',
		'delay',
		'needRepeatedEvent',
		'time',
		'startDelay',
		'startTime',
		'startEvent',
		'standaloneMouseOutsideFilter'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> cleanUpCheckerIn: aTarget [

	checker ifNotNil: [
		checker stop.
		aTarget dequeueTask: checker.
		checker := nil ].
	startEvent ifNil: [ ^ self ].
	startEvent := nil
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> delay: aDuration [

	delay := aDuration
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> initializeAsEventGeneratorHandler [

	needRepeatedEvent := false.
	delay := 0 milliSeconds.
	startDelay := 0 milliSeconds.
	time := BlTime real.
	standaloneMouseOutsideFilter := true
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> mouseUpOutsideEvent: anEvent [

	self stopEvent: anEvent
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> needRepeatedEvent: aBoolean [

	needRepeatedEvent := aBoolean
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> resetTaskFromEvent: anEvent in: aTarget [

	self stopTaskFromEvent: anEvent in: aTarget.
	self reset
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> standaloneMouseOutsideFilter: aBoolean [

	standaloneMouseOutsideFilter := aBoolean
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

	| target eventToUse |
	checker ifNotNil: [ ^ self ].
	target := anEvent currentTarget.
	eventToUse := anEvent copy.
	startTime := time now.
	checker := BlRepeatedTaskAction new
		           delay: delay asDuration;
		           action: [
			           self taskActionFromEvent: eventToUse in: target ].
	standaloneMouseOutsideFilter ifTrue: [
			| filter |
			filter := ToOutsideEventFilter newOneShotInstance
				          eventsToHandle: { BlMouseUpEvent };
				          element: target;
				          yourself.
			target space root addEventFilter: filter ].
	target enqueueTask: checker
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> stopEvent: anEvent [

	self stopTaskFromEvent: anEvent in: anEvent currentTarget
]

{ #category : #'t - event generator handler' }
TToEventGeneratorHandler >> stopTaskFromEvent: anEvent in: aTarget [

	" check the checker to avoid infinite loop in case a cleanUp already occured"
	checker ifNil: [ ^ self ].
	self newStopEvent ifNotNil: [ :stopEvent |
			self cleanUpCheckerIn: aTarget.
			aTarget dispatchEvent: (stopEvent
					 sourceEvent: anEvent;
					 yourself) ]
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
				       needRepeatedEvent ifFalse: [ ^ self ].
				       self newRepeatedEvent
					       sourceEvent: anEvent copy;
					       yourself ].
	aTarget dispatchEvent: evt.
	evt isConsumed ifTrue: [ self stopTaskFromEvent: anEvent in: aTarget ]
]
