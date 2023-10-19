Class {
	#name : #ToCheckedState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToCheckedState >> incompatibleStateClasses [

	^ { ToUncheckedState. ToIndeterminateState }
]

{ #category : #accessing }
ToCheckedState >> lookEventClass [

	^ ToCheckedLookEvent
]
