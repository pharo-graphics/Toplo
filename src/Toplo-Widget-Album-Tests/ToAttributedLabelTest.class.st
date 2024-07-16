"
A ToAttributedLabelTest is a test class for testing the behavior of ToAttributedLabel
"
Class {
	#name : #ToAttributedLabelTest,
	#superclass : #TestCase,
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
