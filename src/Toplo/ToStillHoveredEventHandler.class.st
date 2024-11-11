Class {
	#name : #ToStillHoveredEventHandler,
	#superclass : #ToEventGeneratorHandler,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToStillHoveredEventHandler >> eventsToHandle [

	^ {
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : #'mouse handlers' }
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

{ #category : #'mouse handlers' }
ToStillHoveredEventHandler >> mouseLeaveEvent: anEvent [

	checker ifNil: [ ^ self ].
	self stopTaskIn: anEvent currentTarget
]

{ #category : #'instance creation' }
ToStillHoveredEventHandler >> newRepeatedEvent [

	^ ToStillHoveredEvent new
]

{ #category : #'instance creation' }
ToStillHoveredEventHandler >> newStartEvent [ 

	^ ToStartStillHoveredEvent new
]

{ #category : #'instance creation' }
ToStillHoveredEventHandler >> newStopEvent [

	^ ToStopStillHoveredEvent new
]
