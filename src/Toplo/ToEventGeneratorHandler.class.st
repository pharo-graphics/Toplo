Class {
	#name : #ToEventGeneratorHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToEventGeneratorHandler',
	#classTraits : 'TToEventGeneratorHandler classTrait',
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'event handling' }
ToEventGeneratorHandler >> newRepeatedEvent [
	^ self subclassResponsibility
]

{ #category : #'event handling' }
ToEventGeneratorHandler >> newStartEvent [
	^ self subclassResponsibility
]

{ #category : #'event handling' }
ToEventGeneratorHandler >> newStopEvent [
	^ self subclassResponsibility
]
