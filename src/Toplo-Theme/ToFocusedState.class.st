Class {
	#name : 'ToFocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToFocusedState >> incompatibleStateClasses [

	^ { ToUnfocusedState } 
]

{ #category : 'look event sending' }
ToFocusedState >> lookEventClass [

	^ ToFocusedLookEvent
]
