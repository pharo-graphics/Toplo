"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : #ToSkinStateQueueTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinStateQueueTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.

	^ e

	
]

{ #category : #running }
ToSkinStateQueueTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]
