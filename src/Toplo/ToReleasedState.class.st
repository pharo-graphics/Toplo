Class {
	#name : 'ToReleasedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToReleasedState >> incompatibleStateClasses [

	^ { ToPressedState }   
]

{ #category : 'accessing' }
ToReleasedState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToReleasedState >> lookEventClass [

	^ ToReleasedLookEvent
]
