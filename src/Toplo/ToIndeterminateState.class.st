Class {
	#name : 'ToIndeterminateState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToIndeterminateState >> incompatibleStateClasses [

	^ { ToCheckedState. ToUncheckedState }
]

{ #category : 'look event sending' }
ToIndeterminateState >> lookEventClass [

	^ ToIndeterminateLookEvent
]
