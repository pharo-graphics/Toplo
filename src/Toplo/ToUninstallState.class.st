Class {
	#name : 'ToUninstallState',
	#superclass : 'ToSkinManagementState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'testing' }
ToUninstallState >> isQueueReady: aStateQueue [

	^ true
]

{ #category : 'accessing' }
ToUninstallState >> lookEventClass [

	^ ToUninstallLookEvent
]
