"
A ToInstalledSkinContextTest is a test class for testing the behavior of ToInstalledSkinContext
"
Class {
	#name : #ToInstalledSkinContextTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Skin'
}

{ #category : #tests }
ToInstalledSkinContextTest >> testBorderBuilder [ 
	|  e  |
	e := BlElement new.
	e ensureHaveSkinManager.
	e skinManager ensureHaveSkinContext.
	self assert: e skinManager skinContext borderBuilder notNil
]

{ #category : #tests }
ToInstalledSkinContextTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "

	" this ensures that the skin is removed if the element is added back as a child."

	| skin e space |
	e := ToElement new.
	space := BlSpace new.
	space root addChild: e.
	skin := ToSkin new.
	e skinManager ensureHaveSkinContext.
	e skinManager skinContext installSkin: skin in: e.
	self assert: e skinManager skinUninstaller isNil.
	space root removeChild: e.
	self assert: e skinManager skinUninstaller notNil
]

{ #category : #tests }
ToInstalledSkinContextTest >> testInstallSkinIn [
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
	e skinManager ensureHaveSkinContext.
	e skinManager skinContext installSkin: skin in: e.
	self assert: (e eventDispatcher handlers
			 detect: [ :h |
				 (h isKindOf: BlEventHandler) and: [
					 h eventClass = BlElementRemovedFromSceneGraphEvent ] ]
			 ifNone: [  ]) notNil.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h == skin ]
			 ifNone: [  ]) notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 3
]

{ #category : #tests }
ToInstalledSkinContextTest >> testInstalledSkin [
	| skin e |
	e := BlElement new.
	e ensureHaveSkinManager.
	skin := ToSkin new.
	e skinManager ensureHaveSkinContext.
	e skinManager skinContext installSkin: skin in: e.
	self assert: e skinManager skinContext installedSkin identicalTo: skin
]

{ #category : #tests }
ToInstalledSkinContextTest >> testTextAttributesBuilder [ 
	|  e  |
	e := BlElement new.
	e ensureHaveSkinManager.
	e skinManager ensureHaveSkinContext.
	self assert: e skinManager skinContext textAttributesBuilder notNil
]

{ #category : #tests }
ToInstalledSkinContextTest >> testUninstallSkinIn [

	| skin e eventHandlerCount |
	e := BlElement new.
	eventHandlerCount := e eventDispatcher handlers size.
	e ensureHaveSkinManager.
	self assert: e skinManager notNil.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 1.
	skin := ToSkin new.
	e skinManager ensureHaveSkinContext.
	e skinManager skinContext installSkin: skin in: e.
	self assert: e skinManager notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 3.
	e skinManager skinContext uninstallSkinIn: e.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 1.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h isKindOf: ToSkinManagerEventHandler ]
			 ifNone: [  ]) notNil.
	self assert: e skinManager notNil.
	self assert: e skinManager installedSkin identicalTo: nil
]
