Class {
	#name : #ToInstallState,
	#superclass : #ToSkinManagementState,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToInstallState >> onAppliedOn: anElement fromQueue: aQueue [

	aQueue ifNotNil: [ aQueue installStateApplied: true ].
	super onAppliedOn: anElement fromQueue: aQueue
]

{ #category : #accessing }
ToInstallState >> skinEventClass [

	^ ToInstallSkinEvent
]
