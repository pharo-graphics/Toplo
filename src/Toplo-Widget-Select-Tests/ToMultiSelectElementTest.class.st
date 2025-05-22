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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb popupDataAccessor size equals: 3.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes first firstChild label text asString equals: d1
]

{ #category : #tests }
ToMultiSelectElementTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToMultiSelectElement new.
	d := '#1'.

	cb popupDataAccessor add: d.
	self assert: cb popupDataAccessor size equals: 1.
	cb popupDataAccessor remove: d.
	self assert: cb popupDataAccessor isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testNoSelectedData [

	| cb d |
	cb := ToMultiSelectElement new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb popupDataAccessor addAll: d.
	self assert: cb selecter selectedIndex isZero.
	self assert: cb selecter selectedIndexes isEmpty

]

{ #category : #tests }
ToMultiSelectElementTest >> testNoSelectedData2 [

	| cb |
	cb := ToMultiSelectElement new.
	space root addChild: cb.
	self assert: cb selecter selectedIndex isZero.
	cb selecter selectIndex: 0.
	self waitTestingSpaces.
	self assert: cb selecter selectedIndex isZero
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.
	cb popupDataAccessor removeFirst.
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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.
	cb popupDataAccessor removeAt: 1.
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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.
	cb popupDataAccessor removeFrom:1 to: 1.
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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.
	cb popupDataAccessor removeFrom:1 to: 2.
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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	cb popupDataAccessor removeFrom: 1 to: 3.
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testRemove5 [

	| cb d1 d2 d3 d4|
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	d4 := '#4'.
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3.
			d4 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	cb popupDataAccessor removeFrom: 1 to: 3.
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
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectIndex: 1.
	self assert: cb selecter selectedIndex equals: 1.
	self assert: cb innerElement nodes size equals: 1.

	cb popupDataAccessor removeAll.
	self assert: cb selecter selectedIndexes equals: {  }.
	self assert: cb innerElement nodes isEmpty
]

{ #category : #tests }
ToMultiSelectElementTest >> testSelectAll [

	| cb d1 d2 d3 |
	cb := ToMultiSelectElement new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb popupDataAccessor addAll: {
			d1.
			d2.
			d3 }.
	cb selecter selectAll.
	self assert: cb selecter selectedIndexes equals: #(1 2 3).
	self assert: cb innerElement nodes size equals: 3
]

{ #category : #tests }
ToMultiSelectElementTest >> testWithStructuredData [

	| cb d idx selectedData |
	cb := ToMultiSelectElement new.
	space root addChild: cb.
	cb popupListElement nodeBuilder: [ :node :assoc :holder |
		node addChild: (ToLabel text: assoc key)].
	cb nodeBuilder: [ :node :assoc |
		node addChild: (ToLabel text: assoc key)].
	cb popupListElement dataAccessor addAll: (d := {
			      ('Bee Theme' -> ToBeeTheme).
			      ('Raw Theme' -> ToRawTheme) }).
	cb selecter selectIndex: 1.
	self waitTestingSpaces.
	idx := cb selectionModel selectedIndexes first.
	selectedData := cb popupListElement dataAccessor at: idx.
	self assert: selectedData value identicalTo: ToBeeTheme.
	self assert: cb innerElement nodes first firstChild text asString equals: d first key.
	cb selecter deselectAll.
	self waitTestingSpaces.
	self assert: cb selectionModel selectedIndexes isEmpty.
	self assert: cb innerElement nodes isEmpty
]
