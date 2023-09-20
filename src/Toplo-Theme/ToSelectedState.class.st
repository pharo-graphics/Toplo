Class {
	#name : 'ToSelectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToSelectedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToSelectedLookEvent new
]
