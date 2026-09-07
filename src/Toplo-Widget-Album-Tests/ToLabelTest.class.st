"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Album-Tests-Label'
}

{ #category : #tests }
ToLabelTest >> testBeMonoline [

	| label |
	label := ToLabel new.
	label text: 'A'.
	" monoline by default "
	self assert: (label innerElement isKindOf: ToLabelMonoLineInnerElement).
	label beMultiLine.
	self assert: (label innerElement isKindOf: ToLabelMultiLineInnerElement).
	label beMonoLine.
	self assert: (label innerElement isKindOf: ToLabelMonoLineInnerElement)
]

{ #category : #tests }
ToLabelTest >> testBeMultiline [

	| label |
	label := ToLabel new.
	label text: 'A'.
	label beMultiLine.
	self assert: (label innerElement isKindOf: ToLabelMultiLineInnerElement)
]

{ #category : #tests }
ToLabelTest >> testSkinUpdatedAfterTextChanged [
	" test if changing the text of a ToLabel do rebuild its skin  "

	| label theme hugeFontSize attributes fontSizeAttr prevAttributes  |
	hugeFontSize := 60.

	" declare a specific style sheet theme with one property to change the defont font size "
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty:
		(ToPseudoProperty new
			name: #'text-attributes-with-builder';
			writer: [ :e :v | e text attributes: v attributes. e applyStyle ]).

	theme select: #HUGE asStampSelector style: [ :sr |
		sr
			write: (theme property: #'text-attributes-with-builder')
			with: [ :e | 
				e textAttributesBuilder
					defaultFontSize: hugeFontSize;
					yourself ] ].

	" The default stylesheet theme has no rule by default, so the default attributes is not installed"
	label := ToLabel text: 'Hello'.
	space deferAndSettle: [
		space toTheme: theme.
		space root addChild: label ].
	attributes := label text attributesAt: 1.
	self assert: attributes isEmpty.

	"adding a stamp should renew the skin (and then take the stamp into account)"
	space deferAndSettle: [ label addStamp: #HUGE ].
	fontSizeAttr :=
		label text iterator
			detectAttribute: [ :a | a isKindOf: BlFontSizeDefaultAttribute ]
			ifFound: [ :a | a ]
			ifNone: [
				self fail: 'should have a BlFontSizeDefaultAttribute' ].
	self assert: fontSizeAttr size equals: hugeFontSize.

	" changing the text should renew the skin (and then take the stamp into account again)"
	space deferAndSettle: [ label text: 'Goodbye' ].
	prevAttributes := attributes.
	attributes := label text attributesAt: 1.
	self deny: prevAttributes identicalTo: attributes.
	fontSizeAttr :=
		label text iterator
			detectAttribute: [ :a | a isKindOf: BlFontSizeDefaultAttribute ]
			ifFound: [ :a | a ]
			ifNone: [ self fail: 'should have a BlFontSizeDefaultAttribute' ].
	self assert: fontSizeAttr size equals: hugeFontSize
]

{ #category : #tests }
ToLabelTest >> testText [

	| label |
	label := ToLabel new.
	self assert: label text isEmpty.
	label text: 'A'.
	self assert: (label text isKindOf: BlRopedText).
	self assert: label text asString equals: 'A' 
]

{ #category : #tests }
ToLabelTest >> testTextChangePreserveAttributes2 [
	" test if changing the text of a ToLabel do rebuild its skin  "

	| label hugeFontSize attributes fontSizeAttr prevAttributes |
	self flag: 'To check'.
	hugeFontSize := 60.

	label := ToLabel text: 'Hello'.
	space deferAndSettle: [ space root addChild: label ].
	attributes := label text attributesAt: 1.
	" skin default attributes  "
	self assert: attributes notEmpty.

	space deferAndSettle: [ label defaultFontSize: hugeFontSize ].
	fontSizeAttr :=
		label text iterator
			detectAttribute: [ :a | a isKindOf: BlFontSizeDefaultAttribute ]
			ifFound: [ :a | a ]
			ifNone: [ self fail: 'should have a BlFontSizeDefaultAttribute' ].
	" remember that the skin drives the look so the font size is not applied here "
	"self deny: fontSizeAttr size equals: hugeFontSize.
	self
		assert: fontSizeAttr size
		equals: (label valueOfTokenNamed: #'font-size')."

	" changing the text should renew the skin (and then take the stamp into account again)"
	space deferAndSettle: [ label text: 'Goodbye' ].
	self assert: label text asString equals: 'Goodbye'.
	prevAttributes := attributes.
	attributes := label text attributesAt: 1.
	self deny: prevAttributes identicalTo: attributes.
	fontSizeAttr :=
		label text iterator
			detectAttribute: [ :a | a isKindOf: BlFontSizeDefaultAttribute ]
			ifFound: [ :a | a ]
			ifNone: [ self fail: 'should have a BlFontSizeDefaultAttribute' ].
	self
		assert: fontSizeAttr size
		equals: (label valueOfTokenNamed: #'font-size')
]

{ #category : #tests }
ToLabelTest >> testTextSharedWithInnerElement [

	| label inner |
	label := ToLabel new.
	label text: 'A'.
	self assert: label text identicalTo: label innerElement text.
	inner := label innerElement.
	label beMultiLine.
	self deny: inner identicalTo: label innerElement.
	self assert: label text identicalTo: label innerElement text
]
