Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : 'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToElementState >> appliedOn: anElement [

]

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchEvent: self lookEvent.
	self appliedOn: anElement
]

{ #category : #'look event sending' }
ToElementState >> enqueuedFor: anElement [

]

{ #category : #accessing }
ToElementState >> lookEvent [

	^ self subclassResponsibility 
]
