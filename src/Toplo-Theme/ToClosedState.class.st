Class {
	#name : 'ToClosedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'sending' }
ToClosedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToClosedLookEvent new
]
