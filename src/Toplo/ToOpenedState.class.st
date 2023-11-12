Class {
	#name : #ToOpenedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToOpenedState >> incompatibleStateClasses [

	^ { ToClosedState } 
]

{ #category : #sending }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
