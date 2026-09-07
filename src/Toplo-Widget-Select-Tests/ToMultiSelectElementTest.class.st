"
A ToSingleSelectElementTest is a test class for testing the behavior of ToSingleSelectElement
"
Class {
	#name : #ToMultiSelectElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Select-Tests-Multi'
}

{ #category : #tests }
ToMultiSelectElementTest >> testAddDataAndSelectIndex [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb popupDataAccessor size equals: 3.
	self assert: cb selecter selectedIndex equals: 1.
	self
		assert: cb innerElement nodes first middleElement text asString
		equals: d1
]

{ #category : #tests }
ToMultiSelectElementTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToMultiSelectElement new.
	d := '#1'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor add: d ].
	self assert: cb popupDataAccessor size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor remove: d ].
	self assert: cb popupDataAccessor isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testNoSelectedData [

	| cb d |
	cb := ToMultiSelectElement new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: d ].
	self assert: cb selecter selectedIndex isZero.
	self assert: cb selecter selectedIndexes isEmpty

]

{ #category : #tests }
ToMultiSelectElementTest >> testNoSelectedData2 [

	| cb |
	cb := ToMultiSelectElement new.
	space deferAndSettle: [ space root addChild: cb ].
	self assert: cb selecter selectedIndex isZero.

	space deferAndSettle: [ cb selecter selectOneMoreIndex: 0 ].
	self assert: cb selecter selectedIndex isZero
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb manager popup.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFirst ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove1 [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb manager popup.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeAt: 1 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove2 [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb manager popup.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 1 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove3 [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb manager popup.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 2 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove4 [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb manager popup.
		cb selecter selectIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 3 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove5 [

	| cb d1 d2 d3 d4 |
	cb := ToMultiSelectElement new.
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
		cb manager popup.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeFrom: 1 to: 3 ].
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemoveAll [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
		cb selecter selectIndex: 1 ].

	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb header nodes size equals: 1.

	space deferAndSettle: [ cb popupDataAccessor removeAll ].

	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb header nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testSelectAll [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
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
		cb selecter selectAll ].
	self assert: cb selecter selectedIndexes equals: #(1 2 3).
	self assert: cb innerElement nodes size equals: 3
]

{ #category : #tests }
ToMultiSelectElementTest >> testWithStructuredData [

	| cb d idx selectedData |
	cb := ToMultiSelectElement new.
	d := {
      ('Bee Theme' -> ToBeeTheme).
      ('Raw Theme' -> ToRawTheme) }.
	space deferAndSettle: [
		space root addChild: cb.
		cb popupListElement nodeBuilder: [ :node :assoc :holder |
			node label: (ToLabel text: assoc key) ].
		cb nodeBuilder: [ :node :assoc |
			node label: (ToLabel text: assoc key) ].
		cb popupListElement dataAccessor addAll: d.
		cb selecter selectOneMoreIndex: 1 ].
	self assert: cb selectionModel selectedIndexesCount equals: 1.
	idx := cb selectionModel selectedIndexes first.
	selectedData := cb popupListElement dataAccessor at: idx.
	self assert: selectedData value identicalTo: ToBeeTheme.
	self
		assert: cb innerElement nodes first label text asString
		equals: d first key.

	space deferAndSettle: [ cb selecter deselectAll ].
	self assert: cb selectionModel selectedIndexes isEmpty.
	self assert: cb innerElement nodes isEmpty
]
