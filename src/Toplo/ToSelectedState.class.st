Class {
	#name : 'ToSelectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToSelectedState >> incompatibleStateClasses [

	^ { ToDeselectedState }    
]

{ #category : 'look event sending' }
ToSelectedState >> lookEventClass [

	^ ToSelectedLookEvent
]
