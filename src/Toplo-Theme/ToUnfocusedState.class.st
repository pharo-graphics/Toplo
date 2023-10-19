Class {
	#name : 'ToUnfocusedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToUnfocusedState >> incompatibleStateClasses [

	^ { ToFocusedState }.

]

{ #category : 'accessing' }
ToUnfocusedState >> lookEventClass [

	^ ToUnfocusedLookEvent 
]
