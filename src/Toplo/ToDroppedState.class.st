Class {
	#name : 'ToDroppedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
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
