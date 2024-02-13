"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Album-Tests-Label'
}

{ #category : #tests }
ToLabelTest >> testBeMonoline [

	| lab |
	lab := ToLabel new.
	lab text: 'A'.
	" monoline by default "
	self assert: (lab innerElement isKindOf: ToLabelMonoLineInnerElement).
	lab beMultiLine.
	self assert: (lab innerElement isKindOf: ToLabelMultiLineInnerElement).
	lab beMonoLine.
	self assert: (lab innerElement isKindOf: ToLabelMonoLineInnerElement).

	

]

{ #category : #tests }
ToLabelTest >> testBeMultiline [

	| lab |
	lab := ToLabel new.
	lab text: 'A'.
	lab beMultiLine.
	self assert: (lab innerElement isKindOf: ToLabelMultiLineInnerElement).

]

{ #category : #tests }
ToLabelTest >> testText [

	| lab |
	lab := ToLabel new.
	self assert: lab text isEmpty.
	lab text: 'A'.
	self assert: (lab text isKindOf: BlRopedText).
	self assert: lab text asString equals: 'A' 
]

{ #category : #tests }
ToLabelTest >> testTextSharedWithInnerElement [

	| lab inner |
	lab := ToLabel new.
	lab text: 'A'.
	self assert: lab text identicalTo: lab innerElement text.
	inner := lab innerElement.
	lab beMultiLine.
	self deny: inner identicalTo: lab innerElement.
	self assert: lab text identicalTo: lab innerElement text.
]
