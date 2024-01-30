"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

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
