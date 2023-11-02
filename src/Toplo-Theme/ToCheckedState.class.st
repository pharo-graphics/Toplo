Class {
	#name : 'ToCheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToCheckedState >> incompatibleStateClasses [

	^ { ToUncheckedState. ToIndeterminateState }
]

{ #category : 'accessing' }
ToCheckedState >> lookEventClass [

	^ ToCheckedLookEvent
]
