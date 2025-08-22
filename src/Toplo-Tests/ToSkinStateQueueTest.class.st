"
A ToSkinnableEventHandlerTest is a test class for testing the behavior of ToSkinnableEventHandler
"
Class {
	#name : #ToSkinStateQueueTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #tests }
ToSkinStateQueueTest >> newElementInSpace [

	| e |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	self assert: e skinManager skinInstaller isNil.
	space root addChild: e.
	self assert: e skinManager notNil.
	" to install the element skin  "
	space applyAllSkinInstallers.

	^ e
]

{ #category : #tests }
ToSkinStateQueueTest >> testEnqueueInstallStateFor [

	| q e sk isk |
	e := self newElementInSpace.
	isk := e skinManager installedSkin.
	self assert: isk notNil.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero.
	sk := ToRawSkin new.
	e defaultSkin: sk.
	" the default skin is set "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	" but not installed for now "
	self
		deny: (e skinManager installedSkin)
		identicalTo: sk.
	q enqueueInstallStateForElement: e.
	" on enqueued, the state requests a next pulse and the queue is emptied "
	self assert: q nextStates size equals: 2.
	self assert: q nextStates first class identicalTo: ToInstallState.
	self
		assert: q nextStates second class
		identicalTo: ToEnablementState.
	" the skin should not be installed for now because the element has no skin installer"
	self
		deny: (e skinManager installedSkin)
		identicalTo: sk
]

{ #category : #tests }
ToSkinStateQueueTest >> testEnqueueInstallStateForThroughARequest [

	| q e sk isk |
	e := self newElementInSpace.
	isk := e skinManager installedSkin.
	self assert: isk notNil.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero.
	sk := ToRawSkin new.
	e defaultSkin: sk.
	" the default skin is set "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	" but not installed for now "
	self
		deny: (e skinManager installedSkin)
		identicalTo: sk.
	e skinManager installSkin: sk in: e.
	" on enqueued, the state requests a next pulse and the queue is emptied "
	self assert: q nextStates size equals: 0.
	" the skin should be installed now because the skin management event handler 
	reacts to a ToSkinInstallStateRequest by installing the skin 
	(see #ToSkinManagementEventHandler>>skinInstallStateRequest:)"
	self
		assert: (e skinManager installedSkin)
		identicalTo: sk
]

{ #category : #tests }
ToSkinStateQueueTest >> testInitialize [

	| q |
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil
]

{ #category : #tests }
ToSkinStateQueueTest >> testInitializeThroughAnElement [

	| q e  |
	e := self newElementInSpace.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero
]
