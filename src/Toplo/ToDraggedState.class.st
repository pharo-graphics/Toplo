Class {
	#name : 'ToDraggedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
}

{ #category : 'accessing' }
ToDraggedState >> incompatibleStateClasses [

	^ {  }
]

{ #category : 'testing' }
ToDraggedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToDraggedState >> lookEventClass [

	^ ToDraggedLookEvent
]
