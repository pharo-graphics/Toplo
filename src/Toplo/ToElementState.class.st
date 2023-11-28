Class {
	#name : 'ToElementState',
	#superclass : 'Object',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchEvent: self lookEvent.
	self onAppliedOn: anElement
]

{ #category : 'testing' }
ToElementState >> isQueueReady: aStateQueue [

	^ aStateQueue previousInstallState notNil
]

{ #category : 'accessing' }
ToElementState >> lookEvent [

	^ self subclassResponsibility 
]

{ #category : 'look event sending' }
ToElementState >> onAppliedOn: anElement [

]

{ #category : 'look event sending' }
ToElementState >> onEnqueueRequestFor: anElement inQueue: aStateQueue [

	(self isQueueReady: aStateQueue) ifTrue: [
		aStateQueue enqueueState: self for: anElement ]
]
