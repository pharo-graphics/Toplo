"
A ToChoiceBoxTest is a test class for testing the behavior of ToChoiceBox
"
Class {
	#name : #ToChoiceMenuTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Menu-Tests-Choice menu'
}

{ #category : #asserting }
ToChoiceMenuTest >> assertEmpty: select [

	self assert: select group registeredCheckables isEmpty.
	self assert: select label isNil.
	self assert: select data isEmpty.
	self assert: select selectedData isNil.
	self assert: select dataToTextConverter notNil
]

{ #category : #' tests' }
ToChoiceMenuTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToChoiceMenu new.
	d := '#1'.
	cb data add: d.
	cb data remove: d.
	self assertEmpty: cb

]

{ #category : #' tests' }
ToChoiceMenuTest >> testCheckUncheckWithUncheckStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 1.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d1.
	self assert: cb label text asString equals: d1.
	self assert: cb group registeredCheckables size equals: 3.
	cb group registeredCheckables first uncheck.
	self assert: cb group registeredCheckables first checked not.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb group registeredCheckables third checked not
]

{ #category : #tests }
ToChoiceMenuTest >> testDefaultLabel2 [

	| cb |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	cb data addAll: { 'A'. 'B' }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb group registeredCheckables first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb label text asString equals: 'A'.
	" Unchecking strategy does allow unchecking "
	cb group registeredCheckables first uncheck.
	self assert: cb label text asString equals: 'X'.
	self assert: cb selectedData isNil
]

{ #category : #tests }
ToChoiceMenuTest >> testDefaultLabel3 [

	| cb |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	cb data addAll: { 'A'. 'B' }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb selectData: 'A'.
	self assert: cb group registeredCheckables first checked.
	self assert: cb selectedData identicalTo: cb data first.
	self assert: cb label text asString equals: 'A'.
	" Weak strategy does allow unchecking "
	cb selectData: nil.
	self assert: cb group registeredCheckables first checked not.
	self assert: cb label text equals: cb defaultLabel text.
	self assert: cb selectedData isNil
]

{ #category : #' tests' }
ToChoiceMenuTest >> testEmpty [

	| cb d |
	cb := ToChoiceMenu new.
	self assertEmpty: cb.
	d := 'Some text' asRopedText.
	self assert: (cb dataToTextConverter value: d) equals: d.
]

{ #category : #' tests' }
ToChoiceMenuTest >> testNoSelectedData [

	| cb d |
	cb := ToChoiceMenu new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData isNil.
	self assert: cb label isNil.
	self assert:
		(cb group registeredCheckables noneSatisfy: [ :b | b checked ])
]

{ #category : #tests }
ToChoiceMenuTest >> testNoSelectedDataWithDefaultLabel [

	| cb |
	cb := ToChoiceMenu new.
	cb defaultLabel: (ToLabel text: 'No choice').
	self assert: cb selectedData isNil.
	self assert: cb label text asString equals: 'No choice'.
	self assert:
		(cb group registeredCheckables noneSatisfy: [ :b | b checked ]).
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb label text asString equals: 'No choice'.
	self assert:
		(cb group registeredCheckables noneSatisfy: [ :b | b checked ])
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemove [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 1.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d1.
	self assert: cb label text asString equals: d1.
	self assert: cb group registeredCheckables size equals: 3.
	cb removeData: '#2'.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group registeredCheckables size equals: 2.
	self assert:
		cb group registeredCheckables first label text asString = '#1'.
	self assert:
		cb group registeredCheckables second label text asString = '#3'.
	self assert: cb group registeredCheckables first checked.
	self assert: cb group registeredCheckables second checked not
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithSeparator [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data add: d1.
	cb addSeparator.
	cb data addAll: {
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group registeredCheckables second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group registeredCheckables size equals: 3.
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb label isNil.
	self assert: cb group registeredCheckables first checked not.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group registeredCheckables size equals: 2.
	self assert:
		cb group registeredCheckables first label text asString = '#1'.
	self assert:
		cb group registeredCheckables second label text asString = '#3'
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithSeparator2 [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data add: d1.
	cb addSeparator.
	cb data addAll: {
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group registeredCheckables second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group registeredCheckables size equals: 3.
	cb removeData: '#1'.
	self assert: cb selectedIndex equals: 1.
	self assert: cb label text asString equals: d2.
	self assert: cb group registeredCheckables first checked.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb data first = '#2'.
	self assert: cb data second = '#3'.
	self assert: cb group registeredCheckables size equals: 2.
	self assert:
		cb group registeredCheckables first label text asString = '#2'.
	self assert:
		cb group registeredCheckables second label text asString = '#3'
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithStrictStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group registeredCheckables second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group registeredCheckables size equals: 3.
	" since the strategy is strict, it is impossible to remove a checked item "
	self should: [ cb removeData: '#2' ] raise: Error.
	self assert: cb selectedIndex equals: 2.
	cb selectIndex: 1.
	cb removeData: '#2'.
	self assert: cb group registeredCheckables first checked.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group registeredCheckables size equals: 2.
	self assert:
		cb group registeredCheckables first label text asString = '#1'.
	self assert:
		cb group registeredCheckables second label text asString = '#3'
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithStrictUncheckingStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group registeredCheckables second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group registeredCheckables size equals: 3.
	" since the strategy allows unchecking, it is possible to remove a checked item "
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb group registeredCheckables first checked not.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group registeredCheckables size equals: 2.
	self assert:
		cb group registeredCheckables first label text asString = '#1'.
	self assert:
		cb group registeredCheckables second label text asString = '#3'
]

{ #category : #' tests' }
ToChoiceMenuTest >> testSelectedData1 [

	| cb d |
	cb := ToChoiceMenu new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: d first.
	cb selectData: d second.
	self assert: cb label text asString equals: d second.
	self assert: cb group registeredCheckables second checked
]

{ #category : #' tests' }
ToChoiceMenuTest >> testSelectedData2 [

	| cb d |
	cb := ToChoiceMenu new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: '#1'.
	self should: [ cb selectData: '#99999' ] raise: Error.
	self assert: cb selectedData equals: '#1'.
	self assert: cb label text asString equals: '#1'.
	self assert: cb selectedIndex equals: 1
]

{ #category : #tests }
ToChoiceMenuTest >> testTryNoSelectedDataWithStrictStrategy [

	| cb d |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	cb defaultLabel: (ToLabel text: 'No choice').
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: '#1'.
	self assert: cb label text asString equals: d first.
	" try to uncheck but a strict strategy deny having none selected "
	self should: [ cb selectData: nil ] raise: Error.
	self assert: cb selectedData equals: '#1'.
	self assert: cb label text asString equals: '#1'.
	self assert:
		(cb group registeredCheckables
			 detect: [ :b | b checked ]
			 ifNone: [  ]) notNil
]

{ #category : #tests }
ToChoiceMenuTest >> testWith5StringData [

	| cb d |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 5.
	self assert: cb data size equals: 5.
	self assert: cb selectedData equals: d fifth.
	self assert: cb label text asString equals: d fifth.
	self assert: cb group registeredCheckables size equals: 5.
	self assert: cb defaultLabel isNil.
	" since the strategy is strict, unable to remove a checked item "
	self should: [ cb data removeAll ] raise: Error.
	self assert: cb data size equals: 5.
	self assert: cb selectedData equals: d fifth.
	self assert: cb label text asString equals: d fifth.
	self assert: cb group registeredCheckables size equals: 5
]

{ #category : #tests }
ToChoiceMenuTest >> testWithOneStringData [

	| cb d |
	cb := ToChoiceMenu new.
	d := '#1'.
	cb data add: d.
	cb selectIndex: 1.
	self assert: cb data size equals: 1.
	self assert: cb selectedData equals: d.
	self assert: cb label text asString equals: d.
	self assert: cb group registeredCheckables size equals: 1.
	self assert: cb defaultLabel isNil
]

{ #category : #tests }
ToChoiceMenuTest >> testWithStrictStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 1.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d1.
	self assert: cb label text asString equals: d1.
	self assert: cb group registeredCheckables size equals: 3.
	self assert: cb group registeredCheckables first checked.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb group registeredCheckables third checked not.
	self assert: cb defaultLabel isNil.
	cb group registeredCheckables first uncheck.
	self assert: cb group registeredCheckables first checked
]

{ #category : #tests }
ToChoiceMenuTest >> testWithWeakStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withWeakCheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	self assert: cb data size equals: 3.
	cb selectData: d1.
	self assert: cb label text asString equals: d1.
	self assert: cb group registeredCheckables size equals: 3.
	self assert: cb group registeredCheckables first checked.
	self assert: cb group registeredCheckables second checked not.
	self assert: cb group registeredCheckables third checked not.
	self assert: cb defaultLabel isNil.
	cb group registeredCheckables first uncheck.
	self assert: cb label isNil
]

{ #category : #' tests' }
ToChoiceMenuTest >> testdefaultLabel [

	| cb |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	cb data addAll: { 'A'. 'B' }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb group registeredCheckables first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb label text asString equals: 'A'.
	" strict strategy do not allow unchecking "
	cb group registeredCheckables first uncheck.
	self assert: cb label text asString equals: 'A'.
	self assert: cb selectedData equals: 'A'
]
