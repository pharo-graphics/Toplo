Class {
	#name : 'ToSelectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToSelectedState >> incompatibleStateClasses [

	^ { ToDeselectedState }    
]

{ #category : 'look event sending' }
ToSelectedState >> lookEventClass [

	^ ToSelectedLookEvent
]
