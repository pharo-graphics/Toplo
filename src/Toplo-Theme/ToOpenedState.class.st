Class {
	#name : 'ToOpenedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'sending' }
ToOpenedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToOpenedLookEvent new
]
