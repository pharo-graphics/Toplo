Class {
	#name : 'ToUncheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToUncheckedState >> incompatibleStateClasses [

	^ { ToCheckedState. ToIndeterminateState }
]

{ #category : 'look event sending' }
ToUncheckedState >> lookEventClass [

	^ ToUncheckedLookEvent
]
