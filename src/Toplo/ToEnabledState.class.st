Class {
	#name : 'ToEnabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToEnabledState >> incompatibleStateClasses [

	^ { ToDisabledState }     
]

{ #category : 'accessing' }
ToEnabledState >> lookEventClass [

	^ ToEnabledLookEvent 
]
