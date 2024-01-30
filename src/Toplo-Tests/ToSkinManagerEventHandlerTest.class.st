"
A ToSkinManagementEventHandlerTest is a test class for testing the behavior of ToSkinManagementEventHandler
"
Class {
	#name : #ToSkinManagerEventHandlerTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinManagerEventHandlerTest >> testEventsToHandle [

	| handler |
	handler := ToSkinManagerEventHandler new.
	self assert: handler eventsToHandle anyOne equals: ToSkinManagementEvent
]

{ #category : #tests }
ToSkinManagerEventHandlerTest >> testSkinInstallStateRequest [

	| e nk nextInQueue |
	e := BlElement new.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h isKindOf: ToSkinManagerEventHandler ]) size
		equals: 0.
	" skinManager install on e will add a skin management event handler "
	e ensureHaveSkinManager.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h isKindOf: ToSkinManagerEventHandler ]) size
		equals: 1.
	nk := ToNullSkin new.
	e dispatchEvent: (ToInstallSkinEvent new skin: nk).
	self
		assert: (e skinManager installedSkin)
		identicalTo: nk.
	nextInQueue := e skinManager skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToInstallState).
	nextInQueue := e skinManager skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToEnablementState)
]

{ #category : #tests }
ToSkinManagerEventHandlerTest >> testSkinUninstallStateRequest [

	| e nk |
	e := BlElement new.
	e ensureHaveSkinManager.
	nk := ToNullSkin new.
	e dispatchEvent: (ToInstallSkinEvent new skin: nk).
	self
		assert: (e skinManager installedSkin)
		identicalTo: nk.
	e dispatchEvent: (ToUninstallSkinEvent new skin: nk).
	self assert: (e skinManager installedSkin) isNil.
	" uninstallState is applied directly so the skinContext should be nil "
	self assert: e skinManager skinContext isNil
]
