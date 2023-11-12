Class {
	#name : #ToInstallState,
	#superclass : #ToElementState,
	#category : 'Toplo-Core-States'
}

{ #category : #testing }
ToInstallState >> isPersistent [ 

	^ false
]

{ #category : #'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
