"
A ToRawSkinTest is a test class for testing the behavior of ToRawSkin
"
Class {
	#name : #ToRawSkinTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Skin'
}

{ #category : #tests }
ToRawSkinTest >> collectInstanciableSkinEventClasses [
	" returns all look event classes that implement #sendTo: "

	^ Array streamContents: [ :str |
		  ToSkinEvent allSubclasses do: [ :cls |
			  cls localMethods do: [ :cm |
				  cm selector asSymbol = #sendTo: ifTrue: [ str nextPut: cls ] ] ] ]
]

{ #category : #tests }
ToRawSkinTest >> testBasicStyleSheet [

	| e styleSheet |
	e := ToElement new.
	e extent: 50 asPoint.
	styleSheet := ToStyleSheet new.
	styleSheet select: ToElement asTypeSelector style: [ :sr |
			sr
				when: ToInstallSkinEvent
				write: #background asWritableProperty
				with: Color red ].
	e styleSheet: styleSheet.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e background paint color equals: Color red
]

{ #category : #tests }
ToRawSkinTest >> testButtonWithStyleSheet [

	| e styleSheet |
	e := ToButton new.
	styleSheet := ToStyleSheet new.
	styleSheet select: ToButton asTypeSelector style: [ :sr |
			sr
				when: ToEnabledSkinEvent
				write: #background asWritableProperty
				with: Color red ].
	e styleSheet: styleSheet.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e background paint color equals: Color red
]

{ #category : #tests }
ToRawSkinTest >> testHasAllNecessarySkinEventHandlingMethods [

	| skinEventClasses skinEventSelectors |
	" collect all look event classes "
	skinEventClasses := self collectInstanciableSkinEventClasses.
	" collect all selectors that a raw skin class must implement "
	skinEventSelectors := skinEventClasses collect: [ :cls |
		                      | n |
		                      n := (cls name asString
			                            copyFrom: 3
			                            to: cls name size) asSymbol asMutator.
		                      n asString
			                      at: 1 put: n first asLowercase;
			                      yourself ].
	" check that ToRawSkin has all necessary methods "
	skinEventSelectors do: [ :s |
		self assert: (ToRawSkin canUnderstand: s asSymbol) ]
]

{ #category : #tests }
ToRawSkinTest >> testIsAbleToHandleAnySkinEvent [

	| e skin instanciableSkinEventClasses |
	e := ToElement new.
	space root addChild: e.
	skin := ToRawSkinForTest new.
	e addEventHandler: skin.
	instanciableSkinEventClasses := self collectInstanciableSkinEventClasses.
	instanciableSkinEventClasses do: [ :cls |
		e dispatchEvent: cls new.
		self assert: (skin receivedCountForClass: cls) equals: 1 ]
]

{ #category : #tests }
ToRawSkinTest >> testOnInstalledIn [ 

	| skin e  |
	e := ToElement new.
	space root addChild: e.
	skin := ToRawSkin new.
	skin onInstalledIn: e
]

{ #category : #tests }
ToRawSkinTest >> testOnInstalledInSendsInstallRawStyle [

	| skin e  |
	e := ToElementForRawSkinTest new.
	space root addChild: e.
	skin := ToRawSkin new.
	self assert: e styleInstalled.
	skin onUninstalledIn: e.
	self assert: e styleUninstalled.
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
