Class {
	#name : 'ToOpenedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToOpenedState >> incompatibleStateClasses [

	^ { ToClosedState } 
]

{ #category : 'sending' }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
