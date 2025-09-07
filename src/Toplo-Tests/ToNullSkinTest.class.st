"
A ToNullSkinTest is a test class for testing the behavior of ToNullSkin
"
Class {
	#name : #ToNullSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToNullSkinTest >> testEventsToHandle [ 

	self assert: ToNullSkin new eventsToHandle isEmpty
]

{ #category : #tests }
ToNullSkinTest >> testIsNullSkin [

	self assert: ToNullSkin new isNullSkin
]

{ #category : #tests }
ToNullSkinTest >> testWithASkinInstalledBefore [

	| w installedSkin nsk |
	w := ToElement new.
	self deny: w skinManager newSkinRequested.
	self deny: w skinManager installedSkin isKnownSkin.
	w defaultSkin: ToRawSkin new.
	w ensuredSkinManager requestNewSkinIn: w.
	BlSpace new root addChild: w.
	self deny: w skinManager newSkinRequested.
	" reinstalling has no effect here "
	w skinManager installNewSkinIn: w.
	installedSkin := w skinManager installedSkin.
	self assert: installedSkin isKnownSkin.
	self assert: w skinManager skinStateQueue nextStates isEmpty.
	w defaultSkin: (nsk := ToNullSkin new).
	w skinManager installNewSkinIn: w.
	self deny: w skinManager installedSkin identicalTo: installedSkin.
	self assert: w skinManager installedSkin identicalTo: nsk.
	w skinManager installNewSkinIn: w.
	self assert: w skinManager installedSkin identicalTo: nsk.
	w skinManager requestNewSkinIn: w.
	" should raise an error since an uninstall is not required "
	w skinManager installNewSkinIn: w.
	self assert: w skinManager installedSkin identicalTo: nsk.
	self assert: w skinManager skinStateQueue nextStates isEmpty.
	w skinManager enqueueTransientState: ToHoveredSkinEvent new for: w.
	w skinManagerDo: [ :sm | sm applyEnqueuedStatesFor: w ].
	self assert: w skinManager skinStateQueue nextStates isEmpty
]

{ #category : #tests }
ToNullSkinTest >> testWithNullSkin [

	| w sk |
	w := ToElement new.
	w withNullSkin.
	BlSpace new root addChild: w.
	self deny: w skinManager newSkinRequested.
	w skinManager installNewSkinIn: w.
	self assert: w skinManager installedSkin isNullSkin.

	self assert:
		((sk := w skinManager installedSkin) isKindOf: ToNullSkin).
	w ensuredSkinManager requestNewSkinIn: w.
	w skinManager installNewSkinIn: w.
	self assert: w skinManager installedSkin identicalTo: sk.
	self assert: w skinManager skinStateQueue nextStates isEmpty
]
