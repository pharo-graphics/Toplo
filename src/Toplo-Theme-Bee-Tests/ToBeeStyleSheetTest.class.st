"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : 'ToBeeStyleSheetTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'styleSheet',
		'space'
	],
	#category : 'Toplo-Theme-Bee-Tests',
	#package : 'Toplo-Theme-Bee-Tests'
}

{ #category : 'running' }
ToBeeStyleSheetTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.
	
	ToTheme cleanUp.
	space toTheme: ToBeeLightTheme new.
	
	styleSheet := ToBeeTheme new styleSheet.
	styleSheet inherits: false.
]

{ #category : 'skin' }
ToBeeStyleSheetTest >> testDefaultButtonSkin [

	| button |
	button := ToButton new.
	space root addChild: button.
	space applyAllSkinInstallers.
	space applyAllStyles.

	self assert: button border width equals: (button tokenValue: #'line-width').
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: (button tokenValue: #'color-border').
]

{ #category : 'labeled-icon' }
ToBeeStyleSheetTest >> testLabeledIconWithLabelAndIcon [

	| but li |
	self skip.
	self flag: 'kept for the record'.
	but := ToButton new.
	space root addChild: but.
	but styleSheet: styleSheet.
	but label: (ToLabel text: 'A').
	but icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
			
	space applyAllSkinInstallers.
	space applyAllStyles.

	li := but labeledIcon.
	self assert: (li  constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li  constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li filler constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li filler constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li label constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li label constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).

]

{ #category : 'look updaters' }
ToBeeStyleSheetTest >> testWriteablePropertyList [

	| index count elem |
	elem := ToElement new.
	elem styleSheet: styleSheet.
	index := IdentityDictionary new.
	styleSheet defaultWritablePropertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	styleSheet defaultWritablePropertyList do: [ :p | self assert: (styleSheet writablePropertyNamed: p name) notNil ]
]
