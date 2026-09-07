"
A ToSinnablePropertyTest is a test class for testing the behavior of ToSinnableProperty
"
Class {
	#name : #ToSkinnablePropertyTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Properties'
}

{ #category : #tests }
ToSkinnablePropertyTest >> testRead [

	| w prop  reader v |
	w := ToElement new.
	prop := ToSkinnableProperty new.
	reader := [ :e | e background ].
	prop reader: reader.
	prop name: #background.
	self assert: prop reader equals: reader.
	self assert: prop name equals: #background.
	v := prop read: w.
	self assert: v equals: w background
]

{ #category : #tests }
ToSkinnablePropertyTest >> testWriteTo [

	| w prop writer reader newSkinRequestedAfter |
	w := ToElement new.
	space deferAndSettle: [
		space root addChild: w ].
	self deny: w skinManager newSkinRequested.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e background: v ].
	reader := [ :e | e background ].
	prop writer: writer.
	prop reader: reader.
	prop name: #background.
	self assert: prop writer equals: writer.
	self assert: prop reader equals: reader.
	self assert: prop name equals: #background.

	space deferAndSettle: [
		prop write: Color blue to: w.
		newSkinRequestedAfter := w skinManager newSkinRequested ].
	self assert: newSkinRequestedAfter.

	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToSkinnablePropertyTest >> testWriteToWithDelegation [

	| w prop writer reader newSkinRequestedAfter |
	w := ToLabeledIcon new.
	space deferAndSettle: [
		space root addChild: w.
		w label: (ToLabel text: '') ].
	self assert: w label text asString equals: '' asRopedText asString.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e label text: v ].
	reader := [ :e | e label text ].
	prop writer: writer.
	prop reader: reader.
	prop name: #'label-text'.
	space deferAndSettle: [
		w ensuredSkinManager requestNewSkinIn: w ].
	self deny: w skinManager newSkinRequested.

	space deferAndSettle: [
		prop write: 'Hello' asRopedText to: w.
		newSkinRequestedAfter := w skinManager newSkinRequested ].
	self
		assert: w label text asString
		equals: 'Hello'.
	self
		assert: (prop read: w) asString
		equals: 'Hello'.
	self assert: newSkinRequestedAfter
]

{ #category : #tests }
ToSkinnablePropertyTest >> testWrongDefinition [

	| w prop writer reader |
	w := ToElement new.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e perform: #unknownFeature: with: v ].
	reader := [ :e | e perform: #unknownFeature ].
	prop writer: writer.
	prop reader: reader.
	prop name: #unknownFeature.
	self deny: w skinManager newSkinRequested.
	self should: [ w perform: #unknownFeature ] raise: Error.
	self
		should: [ w perform: #unknownFeature: with: Color red ]
		raise: Error.
	self should: [ prop read: w ] raise: Error.
	self should: [ prop write: Color blue to: w ] raise: Error.
	self deny: w skinManager newSkinRequested
]
