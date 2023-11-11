Class {
	#name : 'ToIndeterminateState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToIndeterminateState >> incompatibleStateClasses [

	^ { ToCheckedState. ToUncheckedState }
]

{ #category : 'look event sending' }
ToIndeterminateState >> lookEventClass [

	^ ToIndeterminateLookEvent
]
