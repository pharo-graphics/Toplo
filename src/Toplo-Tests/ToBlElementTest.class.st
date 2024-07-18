Class {
	#name : #ToBlElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToBlElementTest >> testApplicableListenersFor [

	| e theme |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: (theme applicableListenersFor: e) size equals: 0
	
]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManager [

	| dem |
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	self assert: dem skinManager isNil.
	space root addChild: dem.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.

]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManagerEvenAsChildOfAToElement [

	| dem pane |
	pane := ToPane vertical.
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	pane addChild: dem.
	self assert: dem skinManager isNil.
	space root addChild: pane.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.



]

{ #category : #tests }
ToBlElementTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "
	" this ensures that the skin is removed if the element is added back as a child."

	| e |
	e := BlElement new.
	space root addChild: e.
	self assert: e skinManager isNil.
	space root removeChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager isNil.

	
	
]

{ #category : #tests }
ToBlElementTest >> testEnsureCanManageSkin [

	| e |
	e := BlElement new.
	e ensureCanManageSkin.
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager installedSkin notNil
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testHasStamp [

	| e |
	e := BlElement new.
	self deny: e hasStamp.

	e addStamp: #test.
	self assert: e hasStamp.

	e removeStamp: #test.
	self deny: e hasStamp.
]

{ #category : #tests }
ToBlElementTest >> testRequestSkin [

	| e |
	e := BlElement new.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin isNil.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil
]

{ #category : #tests }
ToBlElementTest >> testRequestSkin2 [

	| e |
	e := BlElement new.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	space root addChild: e.
	self assert: e skinManager isNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager notNil.
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil
]

{ #category : #tests }
ToBlElementTest >> testUnsortedApplicableListenersFor [

	| e theme |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	space root addChild: e.
	self assert: e toStyleStore isNil.
	self applyAllEnqueuedStates.
	self assert: e toStyleStore isNil.
	self waitTestingSpaces.
	self assert: e toStyleStore isNil.
	self assert: (theme unsortedApplicableListenersFor: e) size equals: 0.
	self assert: e toStyleStore isNil.
	e addStamp: #element.
	self assert: e toStyleStore notNil.
	self assert: e skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager isNil.

	self assert: (theme unsortedApplicableListenersFor: e) size equals: 5.

	
]
