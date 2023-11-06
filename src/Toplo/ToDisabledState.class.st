Class {
	#name : 'ToDisabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToDisabledState >> incompatibleStateClasses [

	^ { ToEnabledState }
]

{ #category : 'look event sending' }
ToDisabledState >> lookEventClass [

	^ ToDisabledLookEvent
]
