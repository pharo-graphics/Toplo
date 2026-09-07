Class {
	#name : #ToSkinnablePropertySlotTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #running }
ToSkinnablePropertySlotTest >> testNew [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space deferAndSettle: [ space root addChild: e ].
	self deny: e skinManager installedSkin isUnknownSkin.
	self assert: e skinStateQueueApplicationCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	self assert: e backgroundValue isTransparent.

	space deferAndSettle: [
		e backgroundValue: Color blue.
		space root addChild: e ].
	self assert: e backgroundValue paint color equals: Color blue.
	self assert: e background paint color equals: Color blue.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space deferAndSettle: [
		e backgroundValue: Color blue.
		space root addChild: e.
		self assert: e border isTransparent.
		e borderValue: Color red ].
	self assert: e border paint color equals: Color red.
	self assert: e skinInstalledCount equals: 2
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteTo4 [

	| e  |
	e := ToElementWithSkinnablePropertiesForTest new.

	self deny: e skinManager newSkinRequested.

	space deferAndSettle: [
		e backgroundValue: Color blue.
		e borderValue: Color red.
		self assert: e skinInstalledCount equals: 0.
		space root addChild: e ].
	self assert: e skinInstalledCount equals: 1.

	space deferAndSettle: [ e backgroundValue: Color blue ].
	self assert: e skinInstalledCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 3.
	self deny: e skinManager newSkinRequested.

	space deferAndSettle: [
		e backgroundValue: Color blue.
		e borderValue: Color red ].
	self assert: e skinStateQueueApplicationCount equals: 5.
	self assert: e skinInstalledCount equals: 3.
	self deny: e skinManager newSkinRequested.
	self assert: e skinStateQueueApplicationCount equals: 5.
	self assert: e skinInstalledCount equals: 3
]

{ #category : #running }
ToSkinnablePropertySlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space deferAndSettle: [ space root addChild: e ].
	space deferAndSettle: [
		e backgroundValue: Color blue.
		e borderValue: Color red ].

	self deny: e skinManager newSkinRequested.
	self assert: e skinInstalledCount equals: 2.
	self assert: e skinStateQueueApplicationCount equals: 3
]
