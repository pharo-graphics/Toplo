Class {
	#name : #ToSelectedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToSelectedState >> incompatibleStateClasses [

	^ { ToDeselectedState }    
]

{ #category : #'look event sending' }
ToSelectedState >> lookEventClass [

	^ ToSelectedLookEvent
]
