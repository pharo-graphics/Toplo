Class {
	#name : 'ToExplicitState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToExplicitState >> applyOn: anElement [

	lookEvent := self newLookEventFromSourceEvent: self sourceEvent.
	anElement dispatchEvent: lookEvent.
	self appliedOn: anElement
]

{ #category : 'accessing' }
ToExplicitState >> lookEvent: aLookEvent [

	lookEvent := aLookEvent
]
