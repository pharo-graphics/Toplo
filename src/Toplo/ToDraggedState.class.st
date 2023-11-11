Class {
	#name : 'ToDraggedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
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
