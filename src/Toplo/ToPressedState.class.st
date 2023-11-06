Class {
	#name : 'ToPressedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToPressedState >> incompatibleStateClasses [

	^ { ToReleasedState }  
]

{ #category : 'look event sending' }
ToPressedState >> lookEventClass [

	^ ToPressedLookEvent
]
