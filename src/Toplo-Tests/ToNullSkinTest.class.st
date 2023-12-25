"
A ToNullSkinTest is a test class for testing the behavior of ToNullSkin
"
Class {
	#name : #ToNullSkinTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Theme'
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
	self assert: w skinInstaller isNil.
	self assert: w installedSkin isNil.
	w requestInstallSkin.
	BlSpace new root addChild: w.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	installedSkin := w installedSkin.
	self assert: installedSkin notNil.
	self deny: (installedSkin isKindOf: ToNullSkin).
	self assert: w skinStateQueue nextStates isEmpty.
	w defaultSkin: (nsk := ToNullSkin new).
	w applySkinInstaller.
	self deny: w installedSkin identicalTo: installedSkin.
	self assert: w installedSkin identicalTo: nsk.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: nsk.
	w requestInstallSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: nsk.
	self assert: w skinStateQueue nextStates isEmpty.
	w enqueueSkinState:
		(ToTransientState lookEvent: ToHoveredLookEvent new).
	w applyEnqueuedStates.
	self assert: w skinStateQueue nextStates isEmpty
]

{ #category : #tests }
ToNullSkinTest >> testWithoutSkin [

	| w sk |
	w := ToElement new.
	w withoutSkin.
	BlSpace new root addChild: w.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	self assert: w installedSkin isNullSkin.

	self assert: ((sk := w installedSkin) isKindOf: ToNullSkin).
	w requestInstallSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: sk.
	self assert: w skinStateQueue nextStates isEmpty
]
