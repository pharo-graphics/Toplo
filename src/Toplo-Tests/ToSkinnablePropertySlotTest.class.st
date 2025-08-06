"
A ToSkinnablePropertySlotTest is a test class for testing the behavior of ToSkinnablePropertySlot
"
Class {
	#name : #ToSkinnablePropertySlotTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #running }
ToSkinnablePropertySlotTest >> testNew [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	" -> 1 requestSkin "
	space root addChild: e.
	" -> 1 skin install : the skin is given by the theme. initializing the theme implies 1 requestNewSkin "
	" -> toThemeChanged : -> 1 requestSkin "
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1
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
	" + 2 because of the theme installation "
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	" + 2 requestSkin (#onAddedToSceneGraph is sent 2 times)"
	space root addChild: e.
	self assert: e skinRequestCount equals: 1.

	self assert: e border isTransparent.
	" + 1 requestSkin "
	e borderValue: Color red.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinRequestCount equals: 1.
	self assert: e border paint color equals: Color red.
	self assert: e skinInstalledCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo4 [

	| e requestCpt |
	e := ToElementWithSkinnablePropertiesForTest new.

	self assert: e skinManager skinInstaller isNil.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	" + 1 requestSkin "
	e borderValue: Color red.
	" + 2 requestSkin "
	self assert: e skinInstalledCount equals: 0.
	space root addChild: e.
	self assert: e skinInstalledCount equals: 0.

	requestCpt := e skinRequestCount.
	self assert: requestCpt identicalTo: 1.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	self assert: e skinInstalledCount equals: 0.

	space applyAllSkinInstallers.
	self assert: e skinInstalledCount equals: 1.

	self assert: e skinRequestCount equals: requestCpt.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1.
	self assert: e skinManager skinInstaller isNil.

	e backgroundValue: Color blue.

	" background change -> new skin installer"
	self assert: e skinRequestCount equals: 2.

	e borderValue: Color red.
	" border change -> but no new skin installer because there is already one"
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinRequestCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 1.
	space applyAllSkinInstallers.
	" here states queue is applied two times: 1 for unsinstalling and 2 for installing "
	self assert: e skinStateQueueApplicationCount equals: 3.

	space applyAllEnqueuedStates.

	self assert: e skinRequestCount equals: requestCpt + 1.
	self assert: e skinInstalledCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 3.
	self assert: e skinManager skinInstaller isNil.

	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.

	self assert: e skinManager skinInstaller isNil.
	self assert: e skinRequestCount equals: requestCpt + 1.
	" no new state "
	self assert: e skinStateQueueApplicationCount equals: 3.
	self assert: e skinInstalledCount equals: 2
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space root addChild: e.
	e backgroundValue: Color blue.
	e borderValue: Color red.

	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.

	self assert: e skinManager skinInstaller isNil.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1
]
