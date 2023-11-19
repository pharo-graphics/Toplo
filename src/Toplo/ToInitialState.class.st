Class {
	#name : #ToInitialState,
	#superclass : #ToSkinManagementState,
	#category : 'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToInitialState >> lookEventClass [

	^ ToInitialLookEvent
]
