Class {
	#name : 'ToInstallState',
	#superclass : 'ToManagementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'look event sending' }
ToInstallState >> lookEventClass [

	^ ToInstallLookEvent
]
