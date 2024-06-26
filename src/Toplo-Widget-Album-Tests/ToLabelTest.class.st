"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #ToTestCaseWithSpace,
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
			 writer: [ :e :v | e text attributes: v attributes ]).

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

	space applyAllSkinPhases.
	attributes := label text attributesAt: 1.

	" no attribute because there is no rule that can be applied"
	self assert: attributes isEmpty.

	"adding a stamp should renew the skin (and then take the stamp into account)"
	label addStamp: #HUGE.

	space applyAllSkinPhases.
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
