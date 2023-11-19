"
A ToSkinnablePropertySlotTest is a test class for testing the behavior of ToSkinnablePropertySlot
"
Class {
	#name : #ToSkinnablePropertySlotTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Slots'
}

{ #category : #running }
ToSkinnablePropertySlotTest >> setUp [ 

	super setUp.
	space := self newTestingSpace 
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testNew [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	" -> 1 requestSkin "
	space root addChild: e.
	" -> 1 skin install "
	space applyAllSkinInstallers.
	" -> 1 skin states application "
	space applyAllStyles.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	self assert: e backgroundValue isTransparent.
	" 1 requestSkin (postponed )"
	e backgroundValue: Color blue.
	self assert: e skinRequestCount equals: 1.
	self assert: e backgroundValue paint color equals: Color blue.
	self assert: e background paint color equals: Color blue.
	" + 2 requestSkin (#onAddedToSceneGraph is sent 2 times)"
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	" + 2 requestSkin (#onAddedToSceneGraph is sent 2 times)"
	space root addChild: e.
	self assert: e skinRequestCount equals: 3.
	self assert: e border isTransparent.
	" + 1 requestSkin "
	e borderValue: Color red.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 4.
	self assert: e border paint color equals: Color red.
	self assert: e skinInstallStateCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo4 [

	| e requestCpt |
	e := ToElementWithSkinnablePropertiesForTest new.

	self assert: e skinInstaller isNil.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	" + 1 requestSkin "
	e borderValue: Color red.
	" + 2 requestSkin "
	self assert: e skinInstallStateCount equals: 0.

	space root addChild: e.
	self assert: e skinInstallStateCount equals: 0.

	requestCpt := e skinRequestCount.
	self assert: requestCpt identicalTo: 4.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	self assert: e skinInstallStateCount equals: 0.

	space applyAllSkinInstallers.
	self assert: e skinInstallStateCount equals: 1.
	space applyAllStyles.

	self assert: e skinRequestCount equals: requestCpt + 1.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1.
	self assert: e skinInstaller isNil.

	e backgroundValue: Color blue.
	e borderValue: Color red.
	self assert: e skinInstaller notNil.
	self assert: e skinStatesApplied equals: 1.
	space applyAllSkinInstallers.
	self assert: e skinStatesApplied equals: 2.

	space applyAllStyles.

	self assert: e skinRequestCount equals: requestCpt + 3.
	self assert: e skinInstallStateCount equals: 2.
	self assert: e skinStatesApplied equals: 3.
	self assert: e skinInstaller isNil.

	space applyAllSkinInstallers.
	space applyAllStyles.

	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: requestCpt + 3.
	self assert: e skinStatesApplied equals: 4.
	self assert: e skinInstallStateCount equals: 2
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space root addChild: e.
	e backgroundValue: Color blue.
	e borderValue: Color red.
	
	space applyAllSkinInstallers.
	space applyAllStyles.

	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1.

	
]
