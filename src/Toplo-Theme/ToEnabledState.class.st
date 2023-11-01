Class {
	#name : #ToEnabledState,
	#superclass : #ToElementState,
	#category : 'Toplo-Theme-State'
}

{ #category : #accessing }
ToEnabledState >> incompatibleStateClasses [

	^ { ToDisabledState }     
]

{ #category : #accessing }
ToEnabledState >> lookEventClass [

	^ ToEnabledLookEvent 
]
