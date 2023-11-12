Class {
	#name : #ToDeselectedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToDeselectedState >> incompatibleStateClasses [

	^ { ToSelectedState }
]

{ #category : #accessing }
ToDeselectedState >> lookEventClass [

	^ ToDeselectedLookEvent
]
