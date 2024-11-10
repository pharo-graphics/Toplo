Class {
	#name : #ToStillHoveredEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'checker',
		'delay',
		'time',
		'startDelay',
		'startTime',
		'startEvent'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #accessing }
ToStillHoveredEventHandler >> delay: aDuration [

	delay := aDuration
]

{ #category : #'api - accessing' }
ToStillHoveredEventHandler >> eventsToHandle [

	^ {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #initialization }
ToStillHoveredEventHandler >> initialize [ 

	super initialize.
	delay := 0 milliSeconds.
	startDelay := 0 milliSeconds.
	time := BlTime real
]

{ #category : #'as yet unclassified' }
ToStillHoveredEventHandler >> mouseEnterEvent: anEvent [

	| target |
	checker ifNotNil: [ ^ self ].
	target := anEvent currentTarget.
	startTime := time now.
	checker := BlRepeatedTaskAction new
		           delay: delay asDuration;
		           action: [ self taskActionFromEvent: anEvent in: target].
	target enqueueTask: checker
]

{ #category : #'as yet unclassified' }
ToStillHoveredEventHandler >> mouseLeaveEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget
]

{ #category : #accessing }
ToStillHoveredEventHandler >> startDelay: aDuration [

	startDelay := aDuration
]

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> stopTaskIn: target [

	checker ifNotNil: [
		checker stop.
		target dequeueTask: checker.
		checker := nil ].
	startEvent ifNil: [ ^ self ].
	startEvent := nil.
	target dispatchEvent: ToStopStillHoveredEvent new
]

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> taskActionFromEvent: anEvent in: aTarget [

	| evt now |
	now := time now.
	now >= (startTime + startDelay) ifFalse: [ ^ self ].
	evt := startEvent
		       ifNil: [
			       startEvent := ToStartStillHoveredEvent new
				                     modifiers: anEvent modifiers;
				                     yourself ]
		       ifNotNil: [
			       ToStillHoveredEvent new
				       modifiers: anEvent modifiers;
				       yourself ].
	aTarget dispatchEvent: evt.
	evt isConsumed ifTrue: [ self stopTaskIn: aTarget ]
]
