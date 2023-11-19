"
A TToElementWithPlaceholderTest is a test class for testing the behavior of TToElementWithPlaceholder
"
Class {
	#name : #TToElementWithPlaceholderTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
TToElementWithPlaceholderTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : #tests }
TToElementWithPlaceholderTest >> testCurrentPlaceholderLayer [

	self testHidePlaceholder 
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testHidePlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new size: 100 asPoint.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e currentPlaceholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e hidePlaceholder.
	self assert: e currentPlaceholderLayer isNil.
	self assert: ph parent isNil.
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testIsShowingPlaceholder [

	| e |
	e := ToElementWithPlaceholderForTest new size: 100 asPoint.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self deny: e isShowingPlaceholder.
	
	e isShowingPlaceholder: true.
	self assert: e isShowingPlaceholder.
	
	e isShowingPlaceholder: false.
	self deny: e isShowingPlaceholder.
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderBuilder [

	| e builder |
	e := self testRawPlaceholderBuilder.
	builder := e rawPlaceholderBuilder.
	e placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self assert: builder ~~ e rawPlaceholderBuilder.
	self assert: e rawPlaceholderBuilder notNil.
	self assert: e  currentPlaceholderLayer isNil.
	self assert: (e userData includesKey: #placeholderBuilder).
	e showPlaceholder.
	e placeholderBuilder: nil.
	self assert: e rawPlaceholderBuilder isNil.
	self assert: (e userData includesKey: #placeholderBuilder) not.
	self assert: e  currentPlaceholderLayer isNil.

]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderClass [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: (e placeholderClass inheritsFrom: BlOverlayElement)
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderElevation [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: e placeholderElevation equals: e elevation
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderText [

	| e ph |
	e := ToTextField new size: 100 asPoint.
	e placeholderText: 'Enter text...'.
	e showPlaceholder.
	
	ph := e currentPlaceholderLayer.
	self assert: (ph children first text asString) equals: 'Enter text...'.
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testPlaceholderText2 [

	| e ph builder |
	e := self testRawPlaceholderBuilder.
	e placeholderText: 'Enter text...'.
	e showPlaceholder.

	ph := e currentPlaceholderLayer.
	self assert: ph children first text asString equals: 'Enter text...'.

	builder := e rawPlaceholderBuilder.
	self assert: builder identicalTo: e rawPlaceholderBuilder.
	self assert: e rawPlaceholderBuilder notNil.
	self assert: e currentPlaceholderLayer notNil.
	self assert: (e userData includesKey: #placeholderBuilder).
	e placeholderText: nil.
	self assert: e rawPlaceholderBuilder isNil.
	self assert: e currentPlaceholderLayer isNil.
	self assert: (e userData includesKey: #placeholderBuilder) not
]

{ #category : #tests }
TToElementWithPlaceholderTest >> testRawPlaceholderBuilder [

	| e |
	e := ToElementWithPlaceholderForTest new.
	self assert: e rawPlaceholderBuilder isNil.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	self assert: e rawPlaceholderBuilder notNil.
	self assert: (e rawPlaceholderBuilder isKindOf: BlockClosure ).
	^ e

]

{ #category : #tests }
TToElementWithPlaceholderTest >> testShowPlaceholder [

	| e ph |
	e := ToElementWithPlaceholderForTest new size: 100 asPoint.
	e rawPlaceholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (BlElement new id: #child) ].
	e showPlaceholder.
	ph := e currentPlaceholderLayer.
	self assert: ph notNil.
	self assert: ph parent identicalTo: e.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds extent equals: 100 asPoint.
	e showPlaceholder.
	self assert: e currentPlaceholderLayer identicalTo: ph.
	space root addChild: e.
	self assert: ph space identicalTo: e space.
	e position: 200@100.
	e forceLayout.
	self assert: ph bounds inSpace bounds equals: e bounds inSpace bounds.
	self assert: ph bounds inSpace bounds origin equals: 200@100.
]
