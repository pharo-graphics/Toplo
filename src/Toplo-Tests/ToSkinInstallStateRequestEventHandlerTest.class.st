"
A ToSkinManagementEventHandlerTest is a test class for testing the behavior of ToSkinManagementEventHandler
"
Class {
	#name : 'ToSkinInstallStateRequestEventHandlerTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToSkinInstallStateRequestEventHandlerTest >> testEventsToHandle [

	| handler |
	handler := ToSkinInstallStateRequestEventHandler new.
	self assert: handler eventsToHandle anyOne equals: ToSkinManagementEvent
]

{ #category : 'tests' }
ToSkinInstallStateRequestEventHandlerTest >> testSkinInstallStateRequest [

	| e nk nextInQueue |
	e := BlElement new.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h isKindOf: ToSkinInstallStateRequestEventHandler ]) size
		equals: 0.
	" skinManager install on e will add a skin management event handler "
	e skinManager.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h isKindOf: ToSkinInstallStateRequestEventHandler ]) size
		equals: 1.
	nk := ToNullSkin new.
	e dispatchEvent: (ToSkinInstallStateRequest new skin: nk).
	self assert: e installedSkin identicalTo: nk.
	nextInQueue := e skinManager skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToInstallState).
	nextInQueue := e skinManager skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToEnablementState).

]

{ #category : 'tests' }
ToSkinInstallStateRequestEventHandlerTest >> testSkinUninstallStateRequest [

	| e nk |
	e := BlElement new.
	e skinManager.
	nk := ToNullSkin new.
	e dispatchEvent: (ToSkinInstallStateRequest new skin: nk).
	self assert: e installedSkin identicalTo: nk.
	e dispatchEvent: (ToSkinUninstallStateRequest new skin: nk).
	self assert: e installedSkin isNil.
	" uninstallState is applied directly so the queue should be empty"
	self assert: e skinManager skinStateQueue nextStates size equals: 0
	
]
