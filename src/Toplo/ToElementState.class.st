Class {
	#name : 'ToElementState',
	#superclass : 'Object',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToElementState >> appliedOn: anElement [

]

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchEvent: self lookEvent.
	self appliedOn: anElement
]

{ #category : 'look event sending' }
ToElementState >> enqueuedFor: anElement [
	
	anElement spaceDo: [:sp | sp requestNextPulse ]
]

{ #category : 'accessing' }
ToElementState >> lookEvent [

	^ self subclassResponsibility 
]
