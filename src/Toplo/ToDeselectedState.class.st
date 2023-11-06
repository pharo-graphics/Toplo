Class {
	#name : 'ToDeselectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToDeselectedState >> incompatibleStateClasses [

	^ { ToSelectedState }
]

{ #category : 'accessing' }
ToDeselectedState >> lookEventClass [

	^ ToDeselectedLookEvent
]
