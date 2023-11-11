Class {
	#name : 'ToDeselectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToDeselectedState >> incompatibleStateClasses [

	^ { ToSelectedState }
]

{ #category : 'accessing' }
ToDeselectedState >> lookEventClass [

	^ ToDeselectedLookEvent
]
