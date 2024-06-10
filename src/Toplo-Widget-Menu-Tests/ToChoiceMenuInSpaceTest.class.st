Class {
	#name : #ToChoiceMenuInSpaceTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Menu-Tests-Choice menu'
}

{ #category : #tests }
ToChoiceMenuInSpaceTest >> testChoiceItemRightLabelAlignmentOnFirstPopup [

	| win themeSelect  choiceItem ralign |
	win := ToInnerWindow new.
	themeSelect := ToChoiceMenu new.
	themeSelect withStrictCheckingStrategy.
	themeSelect defaultSelectedIndex: 1.
	themeSelect dataToTextConverter: [ :assoc | assoc key ].
	themeSelect data addAll: {
			('Raw Light' -> ToRawTheme new). }.
	themeSelect addEventHandler: (BlEventHandler
			 on: ToChoiceChangedEvent
			 do: [ space toTheme: themeSelect selectedData value ]).
	space root addChild: themeSelect.
	BlSpace simulateClickOn: themeSelect.
	self waitTestingSpaces.
	space applyAllSkinInstallers.
	self assert: themeSelect menuWindow notNil.
	choiceItem := themeSelect menuWindow root firstChild.
	self assert: choiceItem icon notNil.
	ralign := choiceItem valueOfTokenNamed: #'menu-item-start-alignment'.
	self assert: ralign notNil.
	self assert: choiceItem startAlignment equals: ralign.
	
]

{ #category : #tests }
ToChoiceMenuInSpaceTest >> testWithStructuredDataWithStrictStrategy [

	| cb d |
	cb := ToChoiceMenu new.
	cb withStrictCheckingStrategy.
	cb defaultSelectedIndex: 2.
	cb dataToTextConverter: [ :assoc | assoc key ].
	cb data addAll: (d := {
			      ('Bee Theme' -> ToBeeTheme).
			      ('Raw Theme' -> ToRawTheme) }).
	space root addChild: cb.

	cb addEventHandler: (BlEventHandler
			 on: ToChoiceChangedEvent
			 do: [
			 cb selectedData ifNotNil: [ :data | space toTheme: data value new ] ]).

	cb selectIndex: 1.
	self waitTestingSpaces.
	self assert: cb selectedData value identicalTo: ToBeeTheme.
	self assert: cb label text asString equals: d first key.
	self should: [ cb selectData: nil ] raise: Error.
	self assert: cb selectedIndex equals: 1.
	self assert: cb label text asString equals: d first key.
	self
		assert:
		(cb group registeredCheckables select: [ :b | b checked ]) size
		equals: 1
]

{ #category : #tests }
ToChoiceMenuInSpaceTest >> testWithStructuredDataWithUncheckingStrategy [

	| cb d |
	cb := ToChoiceMenu new.
	cb withUncheckingStrategy.
	space root addChild: cb.
	cb dataToTextConverter: [ :assoc | assoc key ].
	cb data addAll: (d := {
			      ('Bee Theme' -> ToBeeTheme).
			      ('Raw Theme' -> ToRawTheme) }).
	cb selectIndex: 1.
	self waitTestingSpaces.
	self assert: cb selectedData value identicalTo: ToBeeTheme.
	self assert: cb label text asString equals: d first key.
	cb selectData: nil.
	self assert: cb selectedData isNil.
	self assert: cb label isNil.
	self assert:
		(cb group registeredCheckables noneSatisfy: [ :b | b checked ])
]
