"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : #ToDefaultStyleSheetTest,
	#superclass : #TestCase,
	#instVars : [
		'styleSheet'
	],
	#category : #'Toplo-Theme-Tests-DefaultTheme'
}

{ #category : #running }
ToDefaultStyleSheetTest >> setUp [ 

	super setUp.
	ToDefaultTheme cleanUp.
	styleSheet := ToDefaultTheme new styleSheet.
	styleSheet inherits: false.
]

{ #category : #skin }
ToDefaultStyleSheetTest >> testDefaultButtonSkin [

	| ss button writers skin labelSkin ssi |
	ss := ToDefaultStyleSheet new.
	ssi := ToSkinBuilder new.
	button := ToButtonDep new.
	writers := ssi writersFor: button.
	self assert: writers notEmpty.
	skin := ToSkin new.
	skin writers: writers.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: (button stampValue: #'color-border').
	
	button labelText: 'Default'.
	button label privateSkin: nil.
	
	labelSkin := ToSkin new.
	writers := ssi writersFor: button label.
	labelSkin writers: writers.
	button label withSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #'labeled-icon' }
ToDefaultStyleSheetTest >> testLabeledIconWithLabelAndIcon [

	| li |
	li := ToLabeledIcon new.
	li styleSheet: styleSheet.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	self assert: (li icon constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li icon constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li filler constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li filler constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li label constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li label constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).

]

{ #category : #'look updaters' }
ToDefaultStyleSheetTest >> testWriteablePropertyList [

	| index count elem |
	elem := ToElement new.
	elem styleSheet: styleSheet.
	index := IdentityDictionary new.
	styleSheet writablePropertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	styleSheet writablePropertyList do: [ :p | self assert: (styleSheet writablePropertyNamed: p name) notNil ]
]
