"
A ToChoiceBoxTest is a test class for testing the behavior of ToChoiceBox
"
Class {
	#name : 'ToSelectTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Widget-Select-Tests',
	#package : 'Toplo-Widget-Select-Tests'
}

{ #category : 'asserting' }
ToSelectTest >> assertEmpty: select [

	self assert: select group buttons isEmpty.
	self assert: select menuButton label isNil.
	self assert: select data isEmpty.
	self assert: select selectedData isNil.
	self assert: select dataToTextConverter notNil
]

{ #category : ' tests' }
ToSelectTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToSelect new.
	d := '#1'.
	cb data add: d.
	cb data remove: d.
	self assertEmpty: cb

]

{ #category : ' tests' }
ToSelectTest >> testCheckUncheckWithUncheckStrategy [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d1.
	self assert: cb group buttons size equals: 3.
	cb group buttons first uncheck.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not
]

{ #category : ' tests' }
ToSelectTest >> testEmpty [

	| cb d |
	cb := ToSelect new.
	self assertEmpty: cb.
	d := 'Some text' asRopedText.
	self assert: (cb dataToTextConverter value: d) equals: d.
]

{ #category : ' tests' }
ToSelectTest >> testNoSelectedData [

	| cb d |
	cb := ToSelect new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label isNil.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
]

{ #category : 'tests' }
ToSelectTest >> testNoSelectedDataWithPlaceholder [

	| cb |
	cb := ToSelect new.
	cb placeholderBuilder: [ :thePlaceholder :theElement |
		thePlaceholder addChild: (ToLabel text: 'No choice') ].
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ]).
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
]

{ #category : 'tests' }
ToSelectTest >> testNoSelectedDataWithPlaceholder2 [

	| cb d |
	cb := ToSelect new.
	cb placeholder: (ToLabel text: 'No choice').
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: '#1'.
	self assert: cb menuButton label text asString equals: d first.
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b checked ])
]

{ #category : ' tests' }
ToSelectTest >> testPlaceholder [

	| cb |
	cb := ToSelect new.
	cb data addAll: { 'A'. 'B'. }.
	cb placeholder: (ToLabel text: 'X').
	self assert: cb menuButton label text asString equals: 'X'.
	cb group buttons first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb menuButton label text asString equals: 'A'.
	" strict strategy do not allow unchecking "
	cb group buttons first uncheck.
	self assert: cb menuButton label text asString equals: 'A'.
	self assert: cb selectedData equals: 'A'
]

{ #category : 'tests' }
ToSelectTest >> testPlaceholder2 [

	| cb |
	cb := ToSelect new.
	cb withUncheckingStrategy.
	cb data addAll: { 'A'. 'B'. }.
	cb placeholder: (ToLabel text: 'X').
	self assert: cb menuButton label text asString equals: 'X'.
	cb group buttons first check.
	self assert: cb selectedData equals: 'A'.
	self assert: cb menuButton label text asString equals: 'A'.
	" Unchecking strategy does allow unchecking "
	cb group buttons first uncheck.
	self assert: cb menuButton label text asString equals: 'X'.
	self assert: cb selectedData isNil
]

{ #category : 'tests' }
ToSelectTest >> testPlaceholder3 [

	| cb |
	cb := ToSelect new.
	cb withUncheckingStrategy.
	cb data addAll: { 'A'. 'B'. }.
	cb placeholder: (ToLabel text: 'X').
	self assert: cb menuButton label text asString equals: 'X'.
	cb selectData: 'A'.
	self assert: cb group buttons first checked.
	self assert: cb selectedData identicalTo: cb data first.
	self assert: cb menuButton label text asString equals: 'A'.
	" Unchecking strategy does allow unchecking "
	cb selectData: nil.
	self assert: cb group buttons first checked not.
	self assert: cb menuButton label identicalTo: cb placeholder.
	self assert: cb selectedData isNil
]

{ #category : ' tests' }
ToSelectTest >> testRemove [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d1.
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

{ #category : ' tests' }
ToSelectTest >> testRemove2 [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb menuButton label isNil.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.

]

{ #category : ' tests' }
ToSelectTest >> testRemoveWithSeparator [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	cb removeData: '#2'.
	self assert: cb selectedIndex equals: 0.
	self assert: cb menuButton label isNil.
	self assert: cb group buttons first checked not.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#1'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#1'.
	self assert: cb group buttons second label text asString = '#3'.

]

{ #category : ' tests' }
ToSelectTest >> testRemoveWithSeparator2 [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d2.
	self assert: cb group buttons size equals: 3.
	cb removeData: '#1'.
	self assert: cb selectedIndex equals: 2.
	self assert: cb menuButton label text asString equals: d2.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb data first = '#2'.
	self assert: cb data second = '#3'.
	self assert: cb group buttons size equals: 2.
	self assert: cb group buttons first label text asString = '#2'.
	self assert: cb group buttons second label text asString = '#3'.

]

{ #category : ' tests' }
ToSelectTest >> testSelectedData1 [

	| cb d |
	cb := ToSelect new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: d first.
	cb selectData: d second.
	self assert: cb menuButton label text asString equals: d second.
	self assert: cb group buttons second checked
]

{ #category : ' tests' }
ToSelectTest >> testSelectedData2 [

	| cb d |
	cb := ToSelect new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb selectedData equals: '#1'.
	cb selectData: '#99999'.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label isNil.
	self assert: cb selectedIndex isZero
]

{ #category : 'tests' }
ToSelectTest >> testWith5StringData [

	| cb d |
	cb := ToSelect new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	cb selectIndex: 1.
	self assert: cb data size equals: 5.
	self assert: cb selectedData equals: d first.
	self assert: cb menuButton label text asString equals: d first.
	self assert: cb group buttons size equals: 5.
	self assert: cb placeholder isNil.
	cb data removeAll.
	self assertEmpty: cb
]

{ #category : 'tests' }
ToSelectTest >> testWithOneStringData [

	| cb d |
	cb := ToSelect new.
	d := '#1'.
	cb data add: d.
	cb selectIndex: 1.
	self assert: cb data size equals: 1.
	self assert: cb selectedData equals: d.
	self assert: cb menuButton label text asString equals: d.
	self assert: cb group buttons size equals: 1.
	self assert: cb placeholder isNil
]

{ #category : 'tests' }
ToSelectTest >> testWithStrictStrategy [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d1.
	self assert: cb group buttons size equals: 3.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not.
	self assert: cb placeholder isNil.
	cb group buttons first uncheck.
	self assert: cb group buttons first checked
]

{ #category : 'tests' }
ToSelectTest >> testWithUncheckStrategy [

	| cb d1 d2 d3 |
	cb := ToSelect new.
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
	self assert: cb menuButton label text asString equals: d1.
	self assert: cb group buttons size equals: 3.
	self assert: cb group buttons first checked.
	self assert: cb group buttons second checked not.
	self assert: cb group buttons third checked not.
	self assert: cb placeholder isNil.
	cb group buttons first uncheck.
	self assert: cb menuButton label isNil
]
