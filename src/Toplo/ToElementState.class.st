Class {
	#name : #ToElementState,
	#superclass : #Object,
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToElementState class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement [

	| lookEvent |
	lookEvent := self newLookEventFromSourceEvent: self sourceEvent.
	anElement dispatchEvent: lookEvent.
	lookEvent isConsumed ifTrue: [ self sourceEvent consumed: true ]
]

{ #category : #'skin state engine' }
ToElementState >> enqueueIn: anElement [

	anElement skinStateQueue enqueueState: self

]

{ #category : #accessing }
ToElementState >> incompatibleStateClasses [

	^ {  }
]

{ #category : #testing }
ToElementState >> isPersistent [

	^ true
]

{ #category : #accessing }
ToElementState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToElementState >> newLookEventFromSourceEvent: anEvent [

	^ self lookEventClass sourceEvent: anEvent
]

{ #category : #accessing }
ToElementState >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToElementState >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
