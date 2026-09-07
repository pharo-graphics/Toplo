"
A ToSingleSelectElementTest is a test class for testing the behavior of ToSingleSelectElement
"
Class {
	#name : #ToSingleSelectElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Select-Tests-Single'
}

{ #category : #tests }
ToSingleSelectElementTest >> testAddDataAndSelectIndex [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb selecter selectIndex: 1 ].
	self assert: cb popupDataAccessor size equals: 3.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb dataView firstChild text asString equals: d1
]

{ #category : #tests }
ToSingleSelectElementTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToSingleSelectElement new.
	d := '#1'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor add: d ].
	self assert: cb popupDataAccessor size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor remove: d ].
	self assert: cb popupDataAccessor isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testNoSelectedData [

	| cb d |
	cb := ToSingleSelectElement new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: d ].
	self assert: cb selecter selectedIndex isZero.
	self assert: cb selecter selectedIndexes isEmpty

]

{ #category : #tests }
ToSingleSelectElementTest >> testNoSelectedData2 [

	| cb |
	cb := ToSingleSelectElement new.
	space deferAndSettle: [ space root addChild: cb ].
	self assert: cb selecter selectedIndex isZero.

	space deferAndSettle: [ cb selecter selectIndex: 0 ].
	self assert: cb selecter selectedIndex isZero
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFirst ].
	self assert: cb selecter selectedIndexes equals: #().
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove1 [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 } ].
	space deferAndSettle: [
		cb selecter selectIndex: 1 ].
	space deferAndSettle: [ cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeAt: 1 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove2 [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 1 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove3 [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 2 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove4 [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 3 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemove5 [

	| cb d1 d2 d3 d4 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	d4 := '#4'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
				d1.
				d2.
				d3.
				d4 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 3 ].
	self assert: cb selecter selectedIndexes equals: #().
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testRemoveAll [

	| cb d1 d2 d3 |
	cb := ToSingleSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		 cb selecter selectIndex: 1 .
		cb manager popup ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement dataView children size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeAll ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement dataView children isEmpty
]

{ #category : #tests }
ToSingleSelectElementTest >> testWithStructuredData [

	| cb d idx selectedData |
	cb := ToSingleSelectElement new.
	cb popupListElement nodeBuilder: [ :node :assoc :holder |
		node addChild: (ToLabel text: assoc key) ].
	cb dataViewBuilder: [ :dataItemView :assoc |
		dataItemView addChild: (ToLabel text: assoc key) ].
	d := {
      ('Bee Theme' -> ToBeeTheme).
      ('Raw Theme' -> ToRawTheme) }.

	space deferAndSettle: [
		space root addChild: cb.
		cb popupListElement dataAccessor addAll: d.
		cb selecter selectIndex: 1].
	self assert: cb selectionModel selectedIndexesCount equals: 1.
	idx := cb selectionModel selectedIndexes first.
	selectedData := cb popupListElement dataAccessor at: idx.
	self assert: selectedData value identicalTo: ToBeeTheme.
	self assert: cb dataView firstChild text asString equals: d first key.

	space deferAndSettle: [ cb selecter selectIndex: 0 ].
	self assert: cb selectionModel selectedIndexes isEmpty.
	self assert: cb dataView children isEmpty
]
