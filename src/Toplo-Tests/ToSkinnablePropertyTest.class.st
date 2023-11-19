"
A ToSinnablePropertyTest is a test class for testing the behavior of ToSinnableProperty
"
Class {
	#name : #ToSkinnablePropertyTest,
	#superclass : #ToParameterizedHostTest,
	#category : 'Toplo-Tests-Core-Properties'
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

	| w prop  writer reader |
	w := ToElement new.
	BlSpace new root addChild: w.
	self assert: w skinInstaller notNil.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e background: v ].
	reader := [ :e | e background ].
	prop writer: writer.
	prop reader: reader.
	prop name: #background.
	self assert: prop writer equals: writer.
	self assert: prop reader equals: reader.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self deny: w skinInstaller isNil.

	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToSkinnablePropertyTest >> testWriteToWithDelegation [

	| w prop  writer reader |
	w := ToLabeledIcon new.
	w label: (ToLabel text: '').
	self assert: w label text asString equals: '' asRopedText asString.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e label text: v ].
	reader := [ :e | e label text ].
	prop writer: writer.
	prop reader: reader.
	prop name: #'label-text'.
	w requestInstallSkin.
	w applySkinInstaller.
	self assert: w skinInstaller isNil.
	prop write: 'Hello' asRopedText to: w.
	self assert: (w label text equals: 'Hello' asRopedText).
	self assert: (prop read: w) asString equals:'Hello' asRopedText asString.
	self assert: w skinInstaller isNil.
	BlSpace new root addChild: w.
	self deny: w skinInstaller isNil.

]

{ #category : #tests }
ToSkinnablePropertyTest >> testWrongDefinition [

	| w prop  writer reader |
	w := ToElement new.
	prop := ToSkinnableProperty new.
	writer := [ :e :v | e perform: #unknownFeature: with: v ].
	reader := [ :e | e perform: #unknownFeature ].
	prop writer: writer.
	prop reader: reader.
	prop name: #unknownFeature.
	self assert: w skinInstaller isNil.
	self should: [ w  perform: #unknownFeature ] raise: Error.
	self should: [ w  perform: #unknownFeature: with: Color red ] raise: Error.
	self should: [prop read: w ] raise: Error.
	self should: [prop write: Color blue to: w ] raise: Error.
	self assert: w skinInstaller isNil.
]
