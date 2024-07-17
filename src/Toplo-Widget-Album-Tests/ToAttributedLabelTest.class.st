"
A ToAttributedLabelTest is a test class for testing the behavior of ToAttributedLabel
"
Class {
	#name : #ToAttributedLabelTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Widget-Album-Tests-Label'
}

{ #category : #tests }
ToAttributedLabelTest >> testAttributeChangeAppliesOnText [

	| t attr |
	t := ToAttributedLabel new.
	t text: 'Hello'.
	t foreground: Color red.
	attr := t text iterator
		        detectAttribute: [ :a |
		        a isKindOf: BlTextForegroundAttribute ]
		        ifFound: [ :a | a ]
		        ifNone: [
		        self fail: 'should have a BlTextForegroundAttribute' ].
	self assert: attr paint equals: Color red.
	t foreground: Color blue.
	attr := t text iterator
		        detectAttribute: [ :a |
		        a isKindOf: BlTextForegroundAttribute ]
		        ifFound: [ :a | a ]
		        ifNone: [
		        self fail: 'should have a BlTextForegroundAttribute' ].
	self assert: attr paint equals: Color blue
]

{ #category : #tests }
ToAttributedLabelTest >> testHello [

	| t |
	t := ToAttributedLabel new.
	t text: 'Hello'.
	self deny: t text equals: 'Hello' asRopedText.
	self assert: t text asString equals: 'Hello' 

	
]

{ #category : #tests }
ToAttributedLabelTest >> testHelloRed [

	| t attr |
	t := ToAttributedLabel new.
	t text: 'Hello'.
	t foreground: Color red.
	self assert: t attributesBuilder attributes size equals: 1.
	attr := t text iterator
		        detectAttribute: [ :a |
		        a isKindOf: BlTextForegroundAttribute ]
		        ifFound: [ :a | a ]
		        ifNone: [
		        self fail: 'should have a BlTextForegroundAttribute' ].
	self assert: attr paint equals: Color red
]

{ #category : #tests }
ToAttributedLabelTest >> testTextChangePreserveAttributes [

	| t attr |
	t := ToAttributedLabel new.
	t text: 'Hello'.
	t foreground: Color red.
	t text: 'Hello world'.
	self assert: t attributesBuilder attributes size equals: 1.
	attr := t text iterator
		        detectAttribute: [ :a |
		        a isKindOf: BlTextForegroundAttribute ]
		        ifFound: [ :a | a ]
		        ifNone: [
		        self fail: 'should have a BlTextForegroundAttribute' ].
	self assert: attr paint equals: Color red
]

{ #category : #tests }
ToAttributedLabelTest >> testTextChangePreserveAttributes2 [
	" test if changing the text of a ToLabel do rebuild its skin  "

	| label hugeFontSize attributes fontSizeAttr prevAttributes |
	hugeFontSize := 60.

	label := ToAttributedLabel text: 'Hello'.
	space root addChild: label.
	attributes := label text attributesAt: 1.

	" no attribute "
	self assert: attributes isEmpty.

	"adding a stamp should renew the skin (and then take the stamp into account)"
	label addStamp: #HUGE.
	label defaultFontSize: hugeFontSize.
	fontSizeAttr := label text iterator
		                detectAttribute: [ :a |
		                a isKindOf: BlFontSizeDefaultAttribute ]
		                ifFound: [ :a | a ]
		                ifNone: [
		                self fail:
			                'should have a BlFontSizeDefaultAttribute' ].

	self assert: fontSizeAttr size equals: hugeFontSize.
	" changing the text should renew the skin (and then take the stamp into account again)"
	label text: 'Goodbye'.
	self assert: label text asString equals: 'Goodbye'.
	prevAttributes := attributes.
	attributes := label text attributesAt: 1.
	self assert: prevAttributes ~~ attributes.
	fontSizeAttr := label text iterator
		                detectAttribute: [ :a |
		                a isKindOf: BlFontSizeDefaultAttribute ]
		                ifFound: [ :a | a ]
		                ifNone: [
		                self fail:
			                'should have a BlFontSizeDefaultAttribute' ].
	self assert: fontSizeAttr size equals: hugeFontSize
]
