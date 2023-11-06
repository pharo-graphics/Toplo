Class {
	#name : 'ToCheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToCheckedState >> incompatibleStateClasses [

	^ { ToUncheckedState. ToIndeterminateState }
]

{ #category : 'accessing' }
ToCheckedState >> lookEventClass [

	^ ToCheckedLookEvent
]
