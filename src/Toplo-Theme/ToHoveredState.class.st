Class {
	#name : 'ToHoveredState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToHoveredState >> applyOn: anElement [

	anElement dispatchLookEvent: ToHoveredLookEvent new
]
