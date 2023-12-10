"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : 'ToSkinTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToSkinTest >> testEventsToHandle [

	| skin |
	skin := ToSkin new.
	self assert: (skin eventsToHandle allSatisfy: [ :evtCls |
			 evtCls == ToElementLookEvent or: [
				 evtCls inheritsFrom: ToElementLookEvent ] ])
]

{ #category : 'tests' }
ToSkinTest >> testIsNullSkin [

	| skin |
	skin := ToSkin new.
	self deny: skin isNullSkin
]

{ #category : 'tests' }
ToSkinTest >> testOnInstalledIn [ 

	| skin e eventHandlerCount |
	e := BlElement new.
	eventHandlerCount := e eventDispatcher handlers size.
	self assert: e skinManager notNil.
	self assert: e eventDispatcher handlers size equals: eventHandlerCount + 1.
	skin := ToSkin new.
	skin onInstalledIn: e.
	self assert: e skinManager notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self assert: e eventDispatcher handlers size equals: eventHandlerCount + 2
	
	
]
