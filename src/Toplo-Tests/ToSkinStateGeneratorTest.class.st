"
A ToSkinStateGeneratorTest is a test class for testing the behavior of ToSkinStateGenerator
"
Class {
	#name : 'ToSkinStateGeneratorTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToSkinStateGeneratorTest >> testOnInstalledIn [

	| e h |
	e := ToElement new.
	h := ToSkinStateGenerator new.
	e addEventHandler: h.
	self assert: h target identicalTo: e.
	e removeEventHandler: h.
	self assert: h target isNil
]

{ #category : 'tests' }
ToSkinStateGeneratorTest >> testOnUninstalledIn [

	self testOnInstalledIn
]

{ #category : 'tests' }
ToSkinStateGeneratorTest >> testTarget [

	self testOnInstalledIn 
]

{ #category : 'tests' }
ToSkinStateGeneratorTest >> testWantsEvent [

	| e h eventsToHandle eventsToHandleWhenDisabled |
	e := ToElement new.
	h := ToSkinStateGenerator new.
	e addEventHandler: h.
	self assert: e isEnabled.
	eventsToHandle := h eventsToHandle.
	eventsToHandle do: [ :cC |
		self assert: (h wantsEvent: (cC new currentTarget: e)) ].
	e disable.
	self deny: e isEnabled.
	eventsToHandleWhenDisabled := h eventsToHandleWhenDisabled.
	eventsToHandleWhenDisabled do: [ :cC | self assert: (h wantsEvent: (cC new currentTarget: e)) ].
	eventsToHandle do: [ :cC | 
		(eventsToHandleWhenDisabled anySatisfy: [:dC | cC == dC or: [ cC inheritsFrom: dC ] ]) 
			ifTrue: [ self assert: (h wantsEvent: (cC new currentTarget: e)) ]
			ifFalse: [ self deny: (h wantsEvent: (cC new currentTarget: e)) ] ]
]
