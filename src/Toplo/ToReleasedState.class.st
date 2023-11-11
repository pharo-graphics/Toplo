Class {
	#name : #ToReleasedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
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
