Class {
	#name : 'ToStillPressedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToStillPressedState >> incompatibleStateClasses [

	^ { ToPressedState }   
]

{ #category : 'testing' }
ToStillPressedState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToStillPressedState >> lookEventClass [

	^ ToStillPressedLookEvent
]
