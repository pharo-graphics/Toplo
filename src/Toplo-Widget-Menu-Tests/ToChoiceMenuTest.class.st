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

	self assert: select group buttons isEmpty.
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
	cb withUncheckingStrategy.
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
	self assert: cb group buttons size equals: 3.
	cb group buttons first uncheck.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not
]

{ #category : #tests }
ToChoiceMenuTest >> testDefaultLabel2 [

	| cb |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	cb data addAll: { 'A'. 'B'. }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb group buttons first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb label text asString equals: 'A'.
	" Unchecking strategy does allow unchecking "
	cb group buttons first uncheck.
	self assert: cb label text asString equals: 'X'.
	self assert: cb selectedData isNil
]

{ #category : #tests }
ToChoiceMenuTest >> testDefaultLabel3 [

	| cb |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	cb data addAll: { 'A'. 'B'. }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb selectData: 'A'.
	self assert: cb group buttons first checked.
	self assert: cb selectedData identicalTo: cb data first.
	self assert: cb label text asString equals: 'A'.
	" Unchecking strategy does allow unchecking "
	cb selectData: nil.
	self assert: cb group buttons first checked not.
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
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
]

{ #category : #tests }
ToChoiceMenuTest >> testNoSelectedDataWithDefaultLabel [

	| cb |
	cb := ToChoiceMenu new.
	cb defaultLabel: (ToLabel text: 'No choice').
	self assert: cb selectedData isNil.
	self assert: cb label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ]).
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
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
	self assert: cb group buttons size equals: 3.
	cb removeData: '#2'.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not
]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithSeparator [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data add: d1.
	cb addSeparator.
	cb data addAll: {
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group buttons second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb label isNil.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.

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
	self assert: cb group buttons second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	cb removeData: '#1'.
	self assert: cb selectedIndex equals: 1.
	self assert: cb label text asString equals: d2.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#2'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#2'.
	self assert: cb group buttons second label text asString = '#3'.

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
	self assert: cb group buttons second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	" since the strategy is strict, it is impossible to remove a checked item "
	self should: [cb removeData: '#2'] raise: Error.
	self assert: cb selectedIndex equals: 2.
	cb selectIndex: 1.
	cb removeData: '#2'.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.

]

{ #category : #' tests' }
ToChoiceMenuTest >> testRemoveWithStrictUncheckingStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	d1 := '#1'.
	d2 := '#2'.
	d3 := '#3'.
	cb data addAll: {
			d1.
			d2.
			d3 }.
	cb selectIndex: 2.
	self assert: cb group buttons second checked.
	self assert: cb data size equals: 3.
	self assert: cb selectedData equals: d2.
	self assert: cb label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	" since the strategy allows unchecking, it is possible to remove a checked item "
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.

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
	self assert: cb group buttons second checked
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
	self should: [cb selectData: nil ] raise: Error.
	self assert: cb selectedData equals: '#1'.
	self assert: cb label text asString equals: '#1'.
	self assert: (cb group buttons detect: [ :b | b checked ] ifNone: []) notNil
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
	self assert: cb group buttons size equals: 5.
	self assert: cb defaultLabel isNil.
	" since the strategy is strict, unable to remove a checked item "
	self should: [cb data removeAll] raise: Error.
	self assert: cb data size equals: 5.
	self assert: cb selectedData equals: d fifth.
	self assert: cb label text asString equals: d fifth.
	self assert: cb group buttons size equals: 5.

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
	self assert: cb group buttons size equals: 1.
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
	self assert: cb group buttons size equals: 3.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not.
	self assert: cb defaultLabel isNil.
	cb group buttons first uncheck.
	self assert: cb group buttons first checked
]

{ #category : #tests }
ToChoiceMenuTest >> testWithStructuredDataWithStrictStrategy [

	| space cb d |
	space := BlSpace new.
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	cb defaultSelectedIndex: 2.
	cb dataToTextConverter: [ :assoc | assoc key ].
	cb data addAll: (d := {
			('Bee Theme' -> ToBeeTheme).
			('Raw Theme' -> ToRawTheme) }).
	space root addChild: cb.

	cb addEventHandler: (BlEventHandler
			 on: ToChoiceSelectedIndexChangeEvent
			 do: [ cb selectedData ifNotNil: [:data | space toTheme: (data value new) ] ] ).
			
	cb selectIndex: 1.
	self assert: cb selectedData value identicalTo: ToBeeTheme.
	self assert: cb label text asString equals: d first key.
	self should: [cb selectData: nil] raise: Error.
	self assert: cb selectedIndex equals: 1.
	self assert: cb label text asString equals: d first key.
	self assert: (cb group buttons select: [ :b | b checked ]) size equals: 1
]

{ #category : #tests }
ToChoiceMenuTest >> testWithStructuredDataWithUncheckingStrategy [

	| space cb d |
	space := BlSpace new.
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	space root addChild: cb.
	cb dataToTextConverter: [ :assoc | assoc key ].
	cb data addAll: (d := {
			('Bee Theme' -> ToBeeTheme).
			('Raw Theme' -> ToRawTheme) }).
	cb selectIndex: 1.
	self assert: cb selectedData value identicalTo: ToBeeTheme.
	self assert: cb label text asString equals: d first key.
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb label isNil.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
]

{ #category : #tests }
ToChoiceMenuTest >> testWithUncheckStrategy [

	| cb d1 d2 d3 |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
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
	self assert: cb group buttons size equals: 3.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not.
	self assert: cb defaultLabel isNil.
	cb group buttons first uncheck.
	self assert: cb label isNil
]

{ #category : #' tests' }
ToChoiceMenuTest >> testdefaultLabel [

	| cb |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	cb data addAll: { 'A'. 'B'. }.
	cb defaultLabel: (ToLabel text: 'X').
	self assert: cb label text asString equals: 'X'.
	cb group buttons first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb label text asString equals: 'A'.
	" strict strategy do not allow unchecking "
	cb group buttons first uncheck.
	self assert: cb label text asString equals: 'A'.
	self assert: cb selectedData equals: 'A'
]
