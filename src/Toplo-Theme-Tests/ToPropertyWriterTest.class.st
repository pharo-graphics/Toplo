"
A ToPropertyWriterTest is a test class for testing the behavior of ToPropertyWriter
"
Class {
	#name : #ToPropertyWriterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #tests }
ToPropertyWriterTest >> testWithFeaturePropertyAndAnimation [

	| w prop propWriter anim |
	w := ToElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundUpdateAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
]

{ #category : #tests }
ToPropertyWriterTest >> testWithFeaturePropertyWithRawValue [

	| w prop  propWriter |
	w := ToElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter writeTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyWriterTest >> testWithFeaturePropertyWithValuable [

	| w prop  propWriter w2 |
	w := ToElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | w2 := e. Color blue].
	propWriter writeTo: w.
	self assert: w2 identicalTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyWriterTest >> testWithPseudoProperty [

	| w prop  propWriter |
	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer:  [ :e :v | e background: v ].
	prop reader:  [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter writeTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyWriterTest >> testWithPseudoPropertyAndAnimation [

	| w prop propWriter anim |
	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundUpdateAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
]

{ #category : #tests }
ToPropertyWriterTest >> testWithPseudoPropertyWithValuableAndAnimation [

	| w prop propWriter anim w2 |
	w := ToElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | w2 := e. Color blue].
	propWriter animation: (anim := ToBackgroundUpdateAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: w2 identicalTo: w.
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
]
