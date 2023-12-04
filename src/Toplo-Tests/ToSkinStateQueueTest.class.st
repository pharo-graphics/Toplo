"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : 'ToSkinStateQueueTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToSkinStateQueueTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinManager notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.

	^ e

	
]

{ #category : 'running' }
ToSkinStateQueueTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToSkinStateQueueTest >> testEnqueueInstallStateFor [

	| q e sk isk |
	e := self newElementInSpace.
	isk := e installedSkin.
	self assert: isk notNil.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero.
	sk := ToRawSkin new.
	e defaultSkin: sk.
	" the default skin is set "
	self assert: e defaultSkin identicalTo: sk.
	" but not installed for now "
	self deny: e installedSkin identicalTo: sk.
	q enqueueInstallStateForElement: e.
	" on enqueued, the state requests a next pulse and the queue is emptied "
	self assert: q nextStates size equals: 1.
	self assert: q nextStates nextOrNil class identicalTo: ToInstallState.
	" the skin should not be installed for now because the element has no skin installer"
	self deny: e installedSkin identicalTo: sk
]

{ #category : 'tests' }
ToSkinStateQueueTest >> testEnqueueInstallStateForThroughARequest [

	| q e sk isk |
	e := self newElementInSpace.
	isk := e installedSkin.
	self assert: isk notNil.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero.
	sk := ToRawSkin new.
	e defaultSkin: sk.
	" the default skin is set "
	self assert: e defaultSkin identicalTo: sk.
	" but not installed for now "
	self deny: e installedSkin identicalTo: sk.
	e dispatchEvent: (ToSkinInstallStateRequest new skin: sk).
	" on enqueued, the state requests a next pulse and the queue is emptied "
	self assert: q nextStates size equals: 0.
	" the skin should be installed now because the skin management event handler 
	reacts to a ToSkinInstallStateRequest by installing the skin 
	(see #ToSkinManagementEventHandler>>skinInstallStateRequest:)"
	self assert: e installedSkin identicalTo: sk
]

{ #category : 'tests' }
ToSkinStateQueueTest >> testInitialize [

	| q |
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil
]

{ #category : 'tests' }
ToSkinStateQueueTest >> testInitializeThroughAnElement [

	| q e  |
	e := self newElementInSpace.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero
]
