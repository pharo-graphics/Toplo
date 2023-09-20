Class {
	#name : 'ToLeavedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToLeavedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToLeavedLookEvent new
]
