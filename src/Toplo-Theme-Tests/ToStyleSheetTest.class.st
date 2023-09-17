"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #tests }
ToStyleSheetTest >> testNewStyleSheetWith2Rules [

	| styleSheet |
	styleSheet := ToStyleSheet new.
	styleSheet addRules: {
			".button {
				background: blue;
				border: red;
			}"
			((ToStyleClassSelector new styleClass: #button) style: [ :sr |
				 sr
					 property: (styleSheet propertyNamed: #background)
					 value: Color blue.
				 sr property: (styleSheet propertyNamed: #border) value: Color red ]).
			""
			".button:initial {
				background: transparent;
				border: blue;
			}"
			((ToStyleClassSelector new styleClass: #button)
				 event: ToInitialLookEvent
				 style: [ :sr |
					 sr
						 property: (styleSheet propertyNamed: #background)
						 value: Color transparent.
					 sr
						 property: (styleSheet propertyNamed: #border)
						 value: Color blue ]) }

]
