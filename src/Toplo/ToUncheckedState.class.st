Class {
	#name : 'ToUncheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToUncheckedState >> incompatibleStateClasses [

	^ { ToCheckedState. ToIndeterminateState }
]

{ #category : 'look event sending' }
ToUncheckedState >> lookEventClass [

	^ ToUncheckedLookEvent
]
