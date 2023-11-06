Class {
	#name : 'ToDragStartedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Core-ElementStates',
	#package : 'Toplo',
	#tag : 'Core-ElementStates'
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
