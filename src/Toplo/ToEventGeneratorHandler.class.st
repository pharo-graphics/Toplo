Class {
	#name : #ToEventGeneratorHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'checker',
		'delay',
		'time',
		'startDelay',
		'startTime',
		'startEvent'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #accessing }
ToEventGeneratorHandler >> delay: aDuration [

	delay := aDuration
]

{ #category : #initialization }
ToEventGeneratorHandler >> initialize [ 

	super initialize.
	delay := 0 milliSeconds.
	startDelay := 0 milliSeconds.
	time := BlTime real
]

{ #category : #'instance creation' }
ToEventGeneratorHandler >> newRepeatedEvent [ 

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToEventGeneratorHandler >> newStartEvent [ 

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToEventGeneratorHandler >> newStopEvent [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToEventGeneratorHandler >> startDelay: aDuration [

	startDelay := aDuration
]

{ #category : #accessing }
ToEventGeneratorHandler >> stopTaskFromEvent: anEvent in: aTarget [

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

{ #category : #accessing }
ToEventGeneratorHandler >> stopTaskIn: target [

	checker ifNotNil: [
		checker stop.
		target dequeueTask: checker.
		checker := nil ].
	startEvent ifNil: [ ^ self ].
	startEvent := nil.
	target dispatchEvent: self newStopEvent
]

{ #category : #'mouse handlers' }
ToEventGeneratorHandler >> taskActionFromEvent: anEvent in: aTarget [

	| evt now |
	now := time now.
	now >= (startTime + startDelay) ifFalse: [ ^ self ].
	evt := startEvent
		       ifNil: [
			       startEvent := self newStartEvent
				                     sourceEvent: anEvent;
				                     yourself ]
		       ifNotNil: [
			       self newRepeatedEvent 
				       sourceEvent: anEvent;
				       yourself ].
	aTarget dispatchEvent: evt.
	evt isConsumed ifTrue: [ self stopTaskFromEvent: anEvent in: aTarget ]
]
