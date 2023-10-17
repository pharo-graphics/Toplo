Class {
	#name : 'ToUncheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToUncheckedState >> incompatibleStateClasses [

	^ { ToCheckedState. ToIndeterminateState }
]

{ #category : 'look event sending' }
ToUncheckedState >> lookEventClass [

	^ ToUncheckedLookEvent
]
