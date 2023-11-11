Class {
	#name : 'ToStillPressedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
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
