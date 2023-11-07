Class {
	#name : 'ToEnabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToEnabledState >> incompatibleStateClasses [

	^ { ToDisabledState }     
]

{ #category : 'accessing' }
ToEnabledState >> lookEventClass [

	^ ToEnabledLookEvent 
]
