Class {
	#name : 'ToFocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
