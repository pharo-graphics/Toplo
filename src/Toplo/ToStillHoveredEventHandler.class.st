Class {
	#name : #ToStillHoveredEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'checker',
		'delay'
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
	delay := 0 milliSeconds 
]

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> mouseEnterEvent: anEvent [

	| startEvt |
	checker ifNotNil: [ ^ self ].
	checker := BlRepeatedTaskAction new
		           delay: delay asDuration;
		           action: [
			           | evt |
			           evt := ToStillHoveredEvent new
				                  modifiers: anEvent modifiers;
				                  yourself.
			           anEvent currentTarget dispatchEvent: evt.
			           evt isConsumed ifTrue: [
				           self stopTaskIn: anEvent currentTarget ] ].

	startEvt := ToStartStillHoveredEvent new
		            modifiers: anEvent modifiers;
		            yourself.
	anEvent currentTarget dispatchEvent: startEvt.
	startEvt isConsumed ifTrue: [
		self stopTaskIn: anEvent currentTarget.
		^ self ].

	anEvent currentTarget enqueueTask: checker
]

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> mouseLeaveEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget
]

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> stopTaskIn: target [

	checker ifNil: [ ^ self ].
	checker stop.
	target dequeueTask: checker.
	checker := nil.
	target dispatchEvent: ToStopStillHoveredEvent new

]
