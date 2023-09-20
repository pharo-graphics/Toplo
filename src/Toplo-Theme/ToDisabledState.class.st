Class {
	#name : 'ToDisabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToDisabledState >> applyOn: anElement [

	anElement dispatchLookEvent: ToDisabledLookEvent new
]
