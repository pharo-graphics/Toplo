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

	| instanciableLookEventClasses lookEventClasses lookEventSelectors |
	" collect all look event classes "
	instanciableLookEventClasses := ToElementLookEvent allSubclasses.
	" collect all look event classes that implement #sendTo: "
	lookEventClasses := Array streamContents: [ :str |
		                    instanciableLookEventClasses do: [ :cls |
			                    cls localMethods do: [ :cm |
				                    cm selector asSymbol = #sendTo: ifTrue: [
					                    str nextPut: cls ] ] ] ].
	" collect all selectors that a raw skin class must implement "
	lookEventSelectors := lookEventClasses collect: [ :cls |
		                      | n |
		                      n := (cls name asString
			                            copyFrom: 3
			                            to: cls name size) asSymbol asMutator.
		                      n asString
			                      at: 1 put: n first asLowercase;
			                      yourself ].
	" check that ToRawSkin has all necessary methods "
	lookEventSelectors do: [ :s |
		self assert: (ToRawSkin canUnderstand: s asSymbol) ]
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
