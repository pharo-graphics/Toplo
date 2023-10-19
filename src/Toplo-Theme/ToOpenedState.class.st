Class {
	#name : #ToOpenedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToOpenedState >> incompatibleStateClasses [

	^ { ToClosedState } 
]

{ #category : #sending }
ToOpenedState >> lookEventClass [

	^ ToOpenedLookEvent
]
