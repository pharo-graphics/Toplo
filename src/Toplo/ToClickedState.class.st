Class {
	#name : 'ToClickedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'testing' }
ToClickedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToClickedState >> lookEventClass [

	^ ToClickedLookEvent 
]
