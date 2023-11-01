Class {
	#name : #ToClosedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToClosedState >> incompatibleStateClasses [

	^ { ToOpenedState }
]

{ #category : #sending }
ToClosedState >> lookEventClass [

	^ ToClosedLookEvent
]
