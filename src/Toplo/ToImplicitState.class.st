Class {
	#name : 'ToImplicitState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToImplicitState >> applyOn: anElement [

	lookEvent := self newLookEventFromSourceEvent: self sourceEvent.
	anElement dispatchEvent: lookEvent.
	self appliedOn: anElement
]

{ #category : 'accessing' }
ToImplicitState >> lookEventClass [

	^ self subclassResponsibility 
]
