Class {
	#name : 'ToEnablementState',
	#superclass : 'ToPersistentState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToEnablementState >> lookEventClass [

	^ self rawState
		  ifTrue: [ ToEnabledLookEvent ]
		  ifFalse: [ ToDisabledLookEvent ]
]
