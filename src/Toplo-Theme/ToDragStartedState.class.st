Class {
	#name : 'ToDragStartedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
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
