Class {
	#name : #ToSkinStateQueueTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #tests }
ToSkinStateQueueTest >> newElementInSpace [

	| e |
	e := ToElement new.
	self deny: e skinManager newSkinRequested.

	space deferAndSettle: [ space root addChild: e ].
	self assert: e skinManager notNil.
	^ e
]

{ #category : #tests }
ToSkinStateQueueTest >> testEnqueueInstallStateFor [

	| q e sk isk |
	e := self newElementInSpace.
	isk := e skinManager installedSkin.
	self assert: isk isThemeSkin.
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
	q enqueueInstallStateFor: e.
	" on enqueued, the state requests a next pulse and the queue is emptied "
	self assert: q nextStates size equals: 2.
	self assert: q nextStates first class identicalTo: ToInstallState.
	self
		assert: q nextStates second class
		identicalTo: ToIntrinsicState.
	" the skin should not be installed for now because the element has no skin installer"
	self
		deny: (e skinManager installedSkin)
		identicalTo: sk
]

{ #category : #tests }
ToSkinStateQueueTest >> testEnqueueInstallStateForThroughARequest [

	| q e sk isk uninstalled installed |
	e := self newElementInSpace.
	isk := e skinManager installedSkin.
	self assert: isk isThemeSkin.
	q := e skinManager skinStateQueue.
	q := ToSkinStateQueue new.
	self assert: q nextStates notNil.
	self assert: q nextStates size isZero.
	sk := ToRawSkin new.
	
	space deferAndSettle: [
		e defaultSkin: sk.
		self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
		e skinManager uninstallSkinIn: e.
		uninstalled := e skinManager installedSkin.
		e skinManager installSkin: sk in: e.
		installed := e skinManager installedSkin ].
		
	self deny: uninstalled identicalTo: sk.
	self assert: installed identicalTo: sk
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
