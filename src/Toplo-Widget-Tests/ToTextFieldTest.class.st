"
A ToTextFieldTest is a test class for testing the behavior of ToTextField
"
Class {
	#name : #ToTextFieldTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Tests-Album'
}

{ #category : #tests }
ToTextFieldTest >> testPlaceholderText [

	| e ph |
	e := ToTextField new extent: 100 asPoint.
	e placeholderText: 'Enter text...'.
	e showPlaceholder.

	ph := e placeholderLayer.
	self assert: ph children first text asString equals: 'Enter text...'
]
