Class {
	#name : 'ToElementState',
	#superclass : 'Object',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : 'testing' }
ToElementState >> isPressedState [

	^ false
]
