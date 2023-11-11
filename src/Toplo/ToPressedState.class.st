Class {
	#name : #ToPressedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToPressedState >> incompatibleStateClasses [

	^ { ToReleasedState }  
]

{ #category : #'look event sending' }
ToPressedState >> lookEventClass [

	^ ToPressedLookEvent
]
