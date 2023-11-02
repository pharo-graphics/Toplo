Class {
	#name : #ToReleasedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToReleasedState >> incompatibleStateClasses [

	^ { ToPressedState }   
]

{ #category : #accessing }
ToReleasedState >> isPersistent [ 

	^ false
]

{ #category : #accessing }
ToReleasedState >> lookEventClass [

	^ ToReleasedLookEvent
]
