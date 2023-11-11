Class {
	#name : 'ToCheckedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToCheckedState >> incompatibleStateClasses [

	^ { ToUncheckedState. ToIndeterminateState }
]

{ #category : 'accessing' }
ToCheckedState >> lookEventClass [

	^ ToCheckedLookEvent
]
