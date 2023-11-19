Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : 'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchEvent: self lookEvent.
	self onAppliedOn: anElement
]

{ #category : #accessing }
ToElementState >> lookEvent [

	^ self subclassResponsibility 
]

{ #category : #'look event sending' }
ToElementState >> onAppliedOn: anElement [

]

{ #category : #'look event sending' }
ToElementState >> onEnqueuedFor: anElement [
	
	anElement spaceDo: [:sp | sp requestNextPulse ]
]
