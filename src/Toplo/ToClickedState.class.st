Class {
	#name : 'ToClickedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'testing' }
ToClickedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToClickedState >> lookEventClass [

	^ ToClickedLookEvent 
]
