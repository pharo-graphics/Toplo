Class {
	#name : 'ToDroppedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToDroppedState >> incompatibleStateClasses [

	^ {  }
]

{ #category : 'testing' }
ToDroppedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToDroppedState >> lookEventClass [

	^ ToDroppedLookEvent
]
