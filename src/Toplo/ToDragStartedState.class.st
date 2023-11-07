Class {
	#name : 'ToDragStartedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToDragStartedState >> incompatibleStateClasses [

	^ { ToReleasedState }
]

{ #category : 'testing' }
ToDragStartedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToDragStartedState >> lookEventClass [

	^ ToDragStartedLookEvent
]
