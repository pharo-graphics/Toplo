"
A ToChoiceBoxTest is a test class for testing the behavior of ToChoiceBox
"
Class {
	#name : #ToChoiceBoxTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-ChoiceBox'
}

{ #category : #'basic tests' }
ToChoiceBoxTest >> assertEmpty: aChoiceBox [

	self assert: aChoiceBox group buttons isEmpty.	
	self assert: aChoiceBox placeHolder isNil.
	self assert: aChoiceBox menuButton label isNil.
	self assert: aChoiceBox menuButton icon notNil.
	self assert: aChoiceBox data isEmpty.
	self assert: aChoiceBox selectedData isNil.
	self assert: aChoiceBox dataToTextConverter notNil.

]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testAddRemoveOneStringData [

	| cb d |
	cb := ToChoiceBox new.
	d := '#1'.
	cb data add: d.
	cb data remove: d.
	self assertEmpty: cb

]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testEmpty [

	| cb d |
	cb := ToChoiceBox new.
	self assertEmpty: cb.
	d := 'Some text' asRopedText.
	self assert: (cb dataToTextConverter value: d) equals: d.
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testNoSelectedData [

	| cb d |
	cb := ToChoiceBox new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData = '#1'.
	cb selectedData: nil.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label isNil.
	self assert: (cb group buttons noneSatisfy: [ :b | b isChecked ])
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testNoSelectedDataWithPlaceHolder [

	| cb |
	cb := ToChoiceBox new.
	cb placeHolder: (ToLabel text: 'No choice').
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b isChecked ]).
	cb selectedData: nil.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b isChecked ])
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testNoSelectedDataWithPlaceHolder2 [

	| cb d |
	cb := ToChoiceBox new.
	cb placeHolder: (ToLabel text: 'No choice').
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData = '#1'.
	self assert: cb menuButton label text asString equals: d first.
	cb selectedData: nil.
	self assert: cb selectedData isNil.
	self assert: cb menuButton label text asString equals: 'No choice'.
	self assert: (cb group buttons noneSatisfy: [ :b | b isChecked ])
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testSelectedData1 [

	| cb d |
	cb := ToChoiceBox new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData = d first.
	cb selectedData: d second.
	self assert: cb menuButton label text asString = d second.
	self assert: cb group buttons second isChecked
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testSelectedData2 [

	| cb d |
	cb := ToChoiceBox new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb selectedData = '#1'.
	cb selectedData: '#99999'.
	self assert: cb selectedData = '#1'.
	self assert: cb menuButton label text asString = d first.
	self assert: cb group buttons first isChecked
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testWith5StringData [

	| cb d |
	cb := ToChoiceBox new.
	d := { '#1'. '#2'. '#3'. '#4'. '#5' }.
	cb data addAll: d.
	self assert: cb data size equals: 5.
	self assert: cb selectedData equals: d first.
	self assert: cb menuButton label text asString equals: d first.
	self assert: cb menuButton subMenuWindow root children size equals: 5.
	self assert: cb group buttons size equals: 5.
	self assert: cb placeHolder isNil.
	cb data removeAll.
	self assertEmpty: cb
]

{ #category : #'basic tests' }
ToChoiceBoxTest >> testWithOneStringData [

	| cb d |
	cb := ToChoiceBox new.
	d := '#1'.
	cb data add: d.
	self assert: cb data size = 1.
	self assert: cb selectedData = d.
	self assert: cb menuButton label text asString = d.
	self assert: cb menuButton subMenuWindow root children size = 1.
	self assert: cb group buttons size = 1.	
	self assert: cb placeHolder isNil.

]
