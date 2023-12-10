"
A ToRawSkinTest is a test class for testing the behavior of ToRawSkin
"
Class {
	#name : 'ToRawSkinTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToRawSkinTest >> testHasAllNecessaryLookEventHandlingMethods [

	| instanciableLookEventClasses lookEventHandlingMethods |
	instanciableLookEventClasses := ToElementLookEvent allSubclasses select: [ :c | c allSubclasses isEmpty ].
	lookEventHandlingMethods := Array streamContents: [:str | 
		instanciableLookEventClasses do: [ :cls | cls localMethods  ] ]
]

{ #category : 'tests' }
ToRawSkinTest >> testIsAbleToHandleAnyLookEvent [

	| e skin instanciableLookEventClasses |
	e := BlElement new.
	skin := ToRawSkin new.
	e addEventHandler: skin.
	instanciableLookEventClasses := ToElementLookEvent allSubclasses select: [ :c | c allSubclasses isEmpty ].
	instanciableLookEventClasses do: [ :cls | e dispatchEvent: cls new ]
]

{ #category : 'tests' }
ToRawSkinTest >> testOnInstalledIn [ 

	| skin e  |
	e := BlElement new.
	skin := ToRawSkin new.
	skin onInstalledIn: e
]

{ #category : 'tests' }
ToRawSkinTest >> testOnInstalledInSendsInstallRawStyle [

	| skin e  |
	e := ToElementForRawSkinTest new.
	skin := ToRawSkin new.
	self deny: e styleInstalled.
	skin onInstalledIn: e.
	self assert: e styleInstalled.
]

{ #category : 'tests' }
ToRawSkinTest >> testOnUninstalledIn [ 

	| skin e  |
	e := BlElement new.
	skin := ToRawSkin new.
	skin onUninstalledIn: e.
]

{ #category : 'tests' }
ToRawSkinTest >> testOnUninstalledInSendsUninstallRawStyle [

	| skin e  |
	e := ToElementForRawSkinTest new.
	skin := ToRawSkin new.
	self deny: e styleUninstalled.
	skin onUninstalledIn: e.
	self assert: e styleUninstalled.
]
