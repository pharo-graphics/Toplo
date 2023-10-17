Class {
	#name : 'ToIndeterminateState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToIndeterminateState >> incompatibleStateClasses [

	^ { ToCheckedState. ToUncheckedState }
]

{ #category : 'look event sending' }
ToIndeterminateState >> lookEventClass [

	^ ToIndeterminateLookEvent
]
