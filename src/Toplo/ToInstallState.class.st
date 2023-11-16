Class {
	#name : #ToInstallState,
	#superclass : #ToSkinManagementState,
	#category : 'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
