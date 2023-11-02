Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToPressedState >> incompatibleStateClasses [

	^ { ToReleasedState }  
]

{ #category : #'look event sending' }
ToPressedState >> lookEventClass [

	^ ToPressedLookEvent
]
