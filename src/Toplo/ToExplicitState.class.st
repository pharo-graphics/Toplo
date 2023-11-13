Class {
	#name : 'ToExplicitState',
	#superclass : 'ToElementState',
	#instVars : [
		'lookEvent'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToExplicitState class >> lookEvent: aLookEvent [

	^ self new
		  lookEvent: aLookEvent;
		  yourself
]

{ #category : 'look event sending' }
ToExplicitState >> appliedOn: anElement [

	super appliedOn: anElement.
	lookEvent isConsumed ifTrue: [ self sourceEvent consumed: true ].
	lookEvent := nil

]

{ #category : 'look event sending' }
ToExplicitState >> applyOn: anElement [

	lookEvent ifNil: [ Error signal: 'An explicit state must provide its own look event instance' ].
	super applyOn: anElement
]

{ #category : 'accessing' }
ToExplicitState >> lookEvent [

	^ lookEvent 
]

{ #category : 'accessing' }
ToExplicitState >> lookEvent: aLookEvent [

	lookEvent := aLookEvent
]

{ #category : 'accessing' }
ToExplicitState >> sourceEvent [

	^ self lookEvent sourceEvent
]
