"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "
	" this ensures that the skin is removed if the element is added back as a child."

	| skin e space |
	e := BlElement new.
	space := BlSpace new.
	space root addChild: e.
	skin := ToSkin new.
	skin onInstalledIn: e.
	self assert: e skinUninstaller isNil.
	space root removeChild: e.
	self assert: e skinUninstaller notNil.

	
	
]

{ #category : #tests }
ToSkinTest >> testEventsToHandle [

	| skin |
	skin := ToSkin new.
	self assert: (skin eventsToHandle allSatisfy: [ :evtCls |
			 evtCls == ToElementLookEvent or: [
				 evtCls inheritsFrom: ToElementLookEvent ] ])
]

{ #category : #tests }
ToSkinTest >> testIsNullSkin [

	| skin |
	skin := ToSkin new.
	self deny: skin isNullSkin
]

{ #category : #tests }
ToSkinTest >> testOnInstalledIn [

	| skin e eventHandlerCount |
	e := BlElement new.
	eventHandlerCount := e eventDispatcher handlers size.
	e ensureHaveSkinManager.
	self assert: e skinManager notNil.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 1.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h isKindOf: ToSkinManagerEventHandler ]
			 ifNone: [  ]) notNil.
	skin := ToSkin new.
	skin onInstalledIn: e.
	self assert: e skinManager notNil.
	self assert: (e eventDispatcher handlers
			 detect: [ :h |
				 (h isKindOf: BlEventHandler) and: [
					 h eventClass = BlElementRemovedFromSceneGraphEvent ] ]
			 ifNone: [  ]) notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 2
]

{ #category : #tests }
ToSkinTest >> testOnUninstalledIn [ 

	| skin e eventHandlerCount |
	e := BlElement new.
	eventHandlerCount := e eventDispatcher handlers size.
	e ensureHaveSkinManager.
	self assert: e skinManager notNil.
	self assert: e eventDispatcher handlers size equals: eventHandlerCount + 1.
	skin := ToSkin new.
	skin onInstalledIn: e.
	self assert: e skinManager notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self assert: e eventDispatcher handlers size equals: eventHandlerCount + 2.
	skin onUninstalledIn: e.
	self assert: e eventDispatcher handlers size equals: eventHandlerCount + 1.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h isKindOf: ToSkinManagerEventHandler ]
			 ifNone: [  ]) notNil.	self assert: e skinManager notNil.
	self assert: e skinManager installedSkin identicalTo: nil.


	
	
]
