Class {
	#name : 'ToOpenedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToOpenedState >> incompatibleStateClasses [

	^ { ToClosedState } 
]

{ #category : 'sending' }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
