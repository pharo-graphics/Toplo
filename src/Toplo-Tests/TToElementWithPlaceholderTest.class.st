"
A TToElementWithPlaceholderTest is a test class for testing the behavior of TToElementWithPlaceholder
"
Class {
	#name : #TToElementWithPlaceholderTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
TToElementWithPlaceholderTest >> testHidePlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new extent: 100 asPoint.
	e placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e placeholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e hidePlaceholder.
	self assert: e placeholderLayer notNil.
	self deny: e placeholderLayer isVisible.
	self assert: ph parent identicalTo: e
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testNewPlaceholder [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: (e newPlaceholder class inheritsFrom: ToOverlayElement)
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderBuilder [

	| e |
	e := ToElementWithPlaceholderForTest new extent: 100 asPoint.
	e placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self assert: e placeholderLayer notNil.
	self assert: e placeholderLayer firstChild id asSymbol equals: #child
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderClass [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: (e placeholderClass inheritsFrom: ToOverlayElement)
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderElevation [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: e placeholderElevation equals: e elevation
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderLayer [

	self testHidePlaceholder 
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderString [

	| e ph |
	e := ToTextField new extent: 100 asPoint.
	e placeholderString: 'Enter text...'.
	e showPlaceholder.

	ph := e placeholderLayer.
	self assert: ph children first text asString equals: 'Enter text...'
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderText [

	| e ph |
	e := ToTextField new extent: 100 asPoint.
	e placeholderText: 'Enter text...'.
	e showPlaceholder.

	ph := e placeholderLayer.
	self assert: ph children first text asString equals: 'Enter text...'
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testShowPlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new extent: 100 asPoint.
	e placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e placeholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds extent equals: 100 asPoint.
	e showPlaceholder.
	self assert: e placeholderLayer identicalTo: ph.
	space root addChild: e.
	self assert: ph space identicalTo: e space.
	e position: 200 @ 100.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds inSpace bounds origin equals: 200 @ 100
]
