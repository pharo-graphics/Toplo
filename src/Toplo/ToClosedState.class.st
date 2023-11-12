Class {
	#name : #ToClosedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToClosedState >> incompatibleStateClasses [

	^ { ToOpenedState }
]

{ #category : #sending }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
