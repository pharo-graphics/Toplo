Class {
	#name : #ToSkinManagementState,
	#superclass : #ToImplicitState,
	#category : #'Toplo-Core-States'
}

{ #category : #testing }
ToSkinManagementState >> canBeEnqueuedFromElement: anElement inQueue: aStateQueue [

	Error signal: 'A skin management state can''t be enqueued from an element itself'
]
