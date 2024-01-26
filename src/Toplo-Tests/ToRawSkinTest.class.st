"
A ToRawSkinTest is a test class for testing the behavior of ToRawSkin
"
Class {
	#name : #ToRawSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToRawSkinTest >> instanciableLookEventClasses [
	" returns all look event classes that implement #sendTo: "

	^ Array streamContents: [ :str |
		  ToElementLookEvent allSubclasses do: [ :cls |
			  cls localMethods do: [ :cm |
				  cm selector asSymbol = #sendTo: ifTrue: [ str nextPut: cls ] ] ] ]
]

{ #category : #tests }
ToRawSkinTest >> testHasAllNecessaryLookEventHandlingMethods [

	| lookEventClasses lookEventSelectors |
	" collect all look event classes "
	lookEventClasses := self instanciableLookEventClasses.
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

{ #category : #tests }
ToRawSkinTest >> testIsAbleToHandleAnyLookEvent [

	| e skin instanciableLookEventClasses |
	e := ToElement new.
	skin := ToRawSkinForTest new.
	e addEventHandler: skin.
	instanciableLookEventClasses := self instanciableLookEventClasses.
	instanciableLookEventClasses do: [ :cls |
		e dispatchEvent: cls new.
		self assert: (skin receivedCountForClass: cls) equals: 1 ]
]

{ #category : #tests }
ToRawSkinTest >> testOnInstalledIn [ 

	| skin e  |
	e := ToElement new.
	skin := ToRawSkin new.
	skin onInstalledIn: e
]

{ #category : #tests }
ToRawSkinTest >> testOnInstalledInSendsInstallRawStyle [

	| skin e  |
	e := ToElementForRawSkinTest new.
	skin := ToRawSkin new.
	self deny: e styleInstalled.
	skin onInstalledIn: e.
	self assert: e styleInstalled.
]

{ #category : #tests }
ToRawSkinTest >> testOnUninstalledIn [ 

	| skin e  |
	e := ToElement new.
	skin := ToRawSkin new.
	skin onUninstalledIn: e.
]

{ #category : #tests }
ToRawSkinTest >> testOnUninstalledInSendsUninstallRawStyle [

	| skin e  |
	e := ToElementForRawSkinTest new.
	skin := ToRawSkin new.
	self deny: e styleUninstalled.
	skin onUninstalledIn: e.
	self assert: e styleUninstalled.
]
