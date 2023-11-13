Class {
	#name : 'ToElementState',
	#superclass : 'Object',
	#instVars : [
		'sourceEvent',
		'lookEvent'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToElementState class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : 'look event sending' }
ToElementState >> appliedOn: anElement [

	lookEvent isConsumed ifTrue: [ self sourceEvent consumed: true ].
	lookEvent := nil

]

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : 'accessing' }
ToElementState >> lookEvent [

	^ lookEvent
]

{ #category : 'accessing' }
ToElementState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToElementState >> newLookEventFromSourceEvent: anEvent [

	^ self lookEventClass sourceEvent: anEvent
]

{ #category : 'accessing' }
ToElementState >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToElementState >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
