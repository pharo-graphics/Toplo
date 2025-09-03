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
	self deny: e skinManager installedSkin isUnknownSkin.
	self assert: e skinStateQueueApplicationCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	self assert: e backgroundValue isTransparent.
	" 1 requestSkin (postponed )"
	e backgroundValue: Color blue.
	self assert: e backgroundValue paint color equals: Color blue.
	self assert: e background paint color equals: Color blue.
	" + 2 requestSkin (#onAddedToSceneGraph is sent 2 times)"
	space root addChild: e.
	" + 2 because of the theme installation "
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
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

	self assert: e border isTransparent.
	" + 1 requestSkin "
	e borderValue: Color red.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	" this is the second skin request since the first is automatically done when added in space "
	self assert: e border paint color equals: Color red.
	self assert: e skinInstalledCount equals: 2
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo4 [

	| e  |
	e := ToElementWithSkinnablePropertiesForTest new.

	self deny: e skinManager newSkinRequested.
	" + 1 requestSkin "
	e backgroundValue: Color blue.
	" + 1 requestSkin "
	e borderValue: Color red.
	" + 2 requestSkin "
	self assert: e skinInstalledCount equals: 0.
	space root addChild: e.
	self assert: e skinInstalledCount equals: 1.

	e backgroundValue: Color blue.
	self assert: e skinInstalledCount equals: 1.

	space applyAllSkinInstallers.
	self assert: e skinInstalledCount equals: 2.

	self assert: e skinInstalledCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 3.
	self deny: e skinManager newSkinRequested.

	e backgroundValue: Color blue.

	" background change -> new skin installer"
	e borderValue: Color red.
	" border change -> but no new skin installer because there is already one"
	self assert: e skinManager newSkinRequested.
	self assert: e skinStateQueueApplicationCount equals: 3.
	space applyAllSkinInstallers.
	" here states queue is applied two times: 1 for unsinstalling and 2 for installing "
	self assert: e skinStateQueueApplicationCount equals: 5.

	space applyAllEnqueuedStates.

	self assert: e skinInstalledCount equals: 3.
	self assert: e skinStateQueueApplicationCount equals: 5.
	self deny: e skinManager newSkinRequested.

	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.

	self deny: e skinManager newSkinRequested.
	" no new state "
	self assert: e skinStateQueueApplicationCount equals: 5.
	self assert: e skinInstalledCount equals: 3
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

	self deny: e skinManager newSkinRequested.
	self assert: e skinInstalledCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 3
]
