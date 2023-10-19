Class {
	#name : 'ToClosedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToClosedState >> incompatibleStateClasses [

	^ { ToOpenedState }
]

{ #category : 'sending' }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
