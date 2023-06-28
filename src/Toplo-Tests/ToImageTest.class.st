"
A ToImageTest is a test class for testing the behavior of ToImage
"
Class {
	#name : #ToImageTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-Image'
}

{ #category : #tests }
ToImageTest >> testEmptyImage [

	| im passedHere found |
	im := ToImage new.
	self assert: (im innerImage isKindOf: BlElement).
	self assert: im innerForm isNil.
	im forceLayout.
	self assert: im size equals: im defaultInnerImage size.
	passedHere := false.
	im withInnerFormDo: [ :f | passedHere := true ].
	self assert: passedHere not.
	passedHere := false.
	found := true.
	im withInnerFormDo: [ :f | passedHere := true ] ifNone: [ found := false].
	self assert: passedHere not.
	self assert: found not


]

{ #category : #tests }
ToImageTest >> testImageWithForm [

	| im form passedHere found |
	form := (Smalltalk ui icons iconNamed: #delete).
	im := ToImage new innerImage: form.
	self assert: (im innerImage isKindOf: BlElement).
	self assert: (im innerImage background isKindOf: BlImageBackground ).
	self assert: im innerImage background image equals: form.
	self assert: im innerForm equals: form.
	im forceLayout.
	self assert: im size equals: form extent.
	passedHere := false.
	im withInnerFormDo: [ :f | passedHere := true ].
	self assert: passedHere .
	passedHere := false.
	found := true.
	im withInnerFormDo: [ :f | passedHere := true ] ifNone: [ found := false].
	self assert: passedHere .
	self assert: found 

]
