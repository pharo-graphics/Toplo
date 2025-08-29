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
	self assert: w skinManager skinInstaller isNil.
	self deny: w skinManager installedSkin isKnownSkin.
	w defaultSkin: ToRawSkin new.
	w ensuredSkinManager requestInstallSkinIn: w.
	BlSpace new root addChild: w.
	self assert: w skinManager skinInstaller isNil.
	w skinManager applySkinReinstallIn: w.
	installedSkin := w skinManager installedSkin.
	self assert: installedSkin isKnownSkin.
	self assert: w skinManager skinStateQueue nextStates isEmpty.
	w defaultSkin: (nsk := ToNullSkin new).
	w skinManager applySkinReinstallIn: w.
	self deny: w skinManager installedSkin identicalTo: installedSkin.
	self assert: w skinManager installedSkin identicalTo: nsk.
	w skinManager applySkinReinstallIn: w.
	self assert: w skinManager installedSkin identicalTo: nsk.
	w ensuredSkinManager requestInstallSkinIn: w.
	w skinManager applySkinReinstallIn: w.
	self assert: w skinManager installedSkin identicalTo: nsk.
	self assert: w skinManager skinStateQueue nextStates isEmpty.
	w skinManager
		enqueueSkinState:
		(ToTransientState skinEvent: ToHoveredSkinEvent new)
		in: w.
	w skinManagerDo: [ :sm | sm applyEnqueuedStatesIn: w ].
	self assert: w skinManager skinStateQueue nextStates isEmpty
]

{ #category : #tests }
ToNullSkinTest >> testWithNullSkin [

	| w sk |
	w := ToElement new.
	w withNullSkin.
	BlSpace new root addChild: w.
	self assert: w skinManager skinInstaller isNil.
	w skinManager applySkinReinstallIn: w.
	self assert: w skinManager installedSkin isNullSkin.

	self assert:
		((sk := w skinManager installedSkin) isKindOf: ToNullSkin).
	w ensuredSkinManager requestInstallSkinIn: w.
	w skinManager applySkinReinstallIn: w.
	self assert: w skinManager installedSkin identicalTo: sk.
	self assert: w skinManager skinStateQueue nextStates isEmpty
]
