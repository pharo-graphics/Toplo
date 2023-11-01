Class {
	#name : #ToStillPressedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToStillPressedState >> incompatibleStateClasses [

	^ { ToPressedState }   
]

{ #category : #testing }
ToStillPressedState >> isPersistent [ 

	^ false
]

{ #category : #accessing }
ToStillPressedState >> lookEventClass [

	^ ToStillPressedLookEvent
]
