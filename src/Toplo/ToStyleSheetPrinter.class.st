Class {
	#name : 'ToStyleSheetPrinter',
	#superclass : 'Object',
	#instVars : [
		'selectorPrinter',
		'indentLevel'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'accessing' }
ToStyleSheetPrinter class >> styleRules: aStyleRuleList [
	"Initialize the printer with a style rules list to print"

	^ self new styleSheet: (ToStyleSheet new addAllStyleRules: aStyleRuleList)
]

{ #category : 'accessing' }
ToStyleSheetPrinter class >> styleSheet: aToStyleSheet [
	"Initialize the printer with a style sheet to print"

	^ self new styleSheet: aToStyleSheet
]

{ #category : 'accessing' }
ToStyleSheetPrinter class >> toElement: aToElement [
	"Initialize the printer with a ToElement"

	^ self new toElement: aToElement
]

{ #category : 'printing' }
ToStyleSheetPrinter >> crIndentOn: aStream [

	aStream cr.
	indentLevel timesRepeat: [ aStream nextPutAll: '    ' ]
]

{ #category : 'initialization' }
ToStyleSheetPrinter >> initialize [ 

	super initialize.
	indentLevel := 0.
	selectorPrinter := ToSelectorPrinter new.

]

{ #category : 'printing' }
ToStyleSheetPrinter >> printStyleRule: aStyleRule on: aStream [
	"print selector"

	selectorPrinter reset.
	selectorPrinter indent.
	aStyleRule selector accept: selectorPrinter.
	aStream nextPutAll: selectorPrinter contents.

	"print begin of body"
	self crIndentOn: aStream.
	aStream nextPutAll: '{'.

	"print body"
	aStyleRule lookEventListeners do: [ :w |
		self crIndentOn: aStream.
		w printOn: aStream ].

	"print end of body"
	self crIndentOn: aStream.
	aStream
		nextPutAll: '}';
		cr.

	indentLevel := indentLevel + 1.
	selectorPrinter indentLevel: indentLevel.
	"print sub rules"
	aStyleRule styleRules do: [ :rule |
		self printStyleRule: rule on: aStream ].
	indentLevel := indentLevel - 1
]

{ #category : 'printing' }
ToStyleSheetPrinter >> printStyleSheet: aStyleSheet on: aStream [

	aStyleSheet styleRules do: [ :rule |
		self printStyleRule: rule on: aStream ]
]
