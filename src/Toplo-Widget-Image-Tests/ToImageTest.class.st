"
A ToImageTest is a test class for testing the behavior of ToImage
"
Class {
	#name : #ToImageTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Image-Tests'
}

{ #category : #tests }
ToImageTest >> testEmptyImage [

	| im passedHere found |
	im := ToImage new.
	self assert: (im innerImage isKindOf: BlElement).
	self assert: im innerFormImage isNil.
	im forceLayout.
	self assert: im extent equals: im defaultInnerImage extent.
	passedHere := false.
	self
		should: [ im withInnerFormDo: [ :f | passedHere := true ] ]
		raise: NotFound.
	self assert: passedHere not.
	passedHere := false.
	found := true.
	im
		withInnerFormDo: [ :f | passedHere := true ]
		ifNone: [ found := false ].
	self assert: passedHere not.
	self assert: found not
]

{ #category : #tests }
ToImageTest >> testImageWithForm [

	| im form passedHere found |
	form := Smalltalk ui icons iconNamed: #delete.
	im := ToImage new innerImage: form.
	self assert: (im innerImage isKindOf: BlElement).
	self assert: (im innerImage background isKindOf: BlImageBackground).
	self assert: im innerImage background image equals: form.
	self assert: im innerFormImage equals: form.
	im forceLayout.
	self assert: im extent equals: form extent.
	passedHere := false.
	im withInnerFormDo: [ :f | passedHere := true ].
	self assert: passedHere.
	passedHere := false.
	found := true.
	im
		withInnerFormDo: [ :f | passedHere := true ]
		ifNone: [ found := false ].
	self assert: passedHere.
	self assert: found
]
