Class {
	#name : 'ToDisabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToDisabledState >> incompatibleStateClasses [

	^ { ToEnabledState }
]

{ #category : 'look event sending' }
ToDisabledState >> lookEventClass [

	^ ToDisabledLookEvent
]
