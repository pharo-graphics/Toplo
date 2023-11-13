Class {
	#name : 'ToImplicitState',
	#superclass : 'ToElementState',
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToImplicitState class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : 'accessing' }
ToImplicitState >> lookEvent [

	^ self newLookEvent 
]

{ #category : 'accessing' }
ToImplicitState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToImplicitState >> newLookEvent [

	^ self lookEventClass sourceEvent: self sourceEvent 
]

{ #category : 'accessing' }
ToImplicitState >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToImplicitState >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
