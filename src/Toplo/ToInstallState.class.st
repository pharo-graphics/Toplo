Class {
	#name : #ToInstallState,
	#superclass : #ToSkinManagementState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToInstallState >> applyOn: anElement fromQueue: aQueue [

	super applyOn: anElement fromQueue: aQueue.
	aQueue ifNotNil: [ aQueue installStateApplied: true ].
]

{ #category : #accessing }
ToInstallState >> skinEventClass [

	^ ToInstallSkinEvent
]
