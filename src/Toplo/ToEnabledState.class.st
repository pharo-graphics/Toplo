Class {
	#name : #ToEnabledState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #accessing }
ToEnabledState >> incompatibleStateClasses [

	^ { ToDisabledState }     
]

{ #category : #accessing }
ToEnabledState >> lookEventClass [

	^ ToEnabledLookEvent 
]
