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
ToLabelTest >> testSkinUpdatedAfterTextChanged [
	" test if changing the text of a ToLabel do rebuild its skin  "

	| label theme hugeFontSize attributes fontSizeAttr prevAttributes  |
	hugeFontSize := 60.

	" declare a specific style sheet theme with one property to change the defont font size "
	theme := ToStyleSheetTheme new.
	theme styleSheet addWritableProperty: (ToPseudoProperty new
			 name: #'text-attributes-with-builder';
			 writer: [ :e :v | e text attributes: v attributes. e applyStyle ]).

	theme select: #HUGE asStampSelector style: [ :sr |
		sr
			write: (theme property: #'text-attributes-with-builder')
			with: [ :e | 
				e textAttributesBuilder
					defaultFontSize: hugeFontSize;
					yourself ] ].

	space toTheme: theme.
	label := ToLabel text: 'Hello'.
	space root addChild: label.

	self waitTestingSpaces.
	attributes := label text attributesAt: 1.

	" The default stylesheet theme has no rule by default, so the default attributes is not installed"
	self assert: attributes isEmpty.
	"adding a stamp should renew the skin (and then take the stamp into account)"
	label addStamp: #HUGE.

	self waitTestingSpaces.
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
	space applyAllSkinPhases.
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
ToLabelTest >> testTextChangePreserveAttributes2 [
	" test if changing the text of a ToLabel do rebuild its skin  "

	| label hugeFontSize attributes fontSizeAttr prevAttributes |
	self flag: 'To check'.
	hugeFontSize := 60.

	label := ToLabel text: 'Hello'.
	space root addChild: label.
	space applyAllSkinPhases.
	attributes := label text attributesAt: 1.
	" skin default attributes  "
	self assert: attributes notEmpty.

	label defaultFontSize: hugeFontSize.
	fontSizeAttr := label text iterator
		                detectAttribute: [ :a |
		                a isKindOf: BlFontSizeDefaultAttribute ]
		                ifFound: [ :a | a ]
		                ifNone: [
		                self fail:
			                'should have a BlFontSizeDefaultAttribute' ].
	" remember that the skin drives the look so the font size is not applied here "
	"self deny: fontSizeAttr size equals: hugeFontSize.
	self
		assert: fontSizeAttr size
		equals: (label valueOfTokenNamed: #'font-size')."
	space applyAllSkinPhases.
	" changing the text should renew the skin (and then take the stamp into account again)"
	label text: 'Goodbye'.
	space applyAllSkinPhases.

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
	self
		assert: fontSizeAttr size
		equals: (label valueOfTokenNamed: #'font-size')
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
