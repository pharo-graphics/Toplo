"
A ToStyleRuleTest is a test class for testing the behavior of ToStyleRule
"
Class {
	#name : #ToStyleRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'propertyIndex'
	],
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #running }
ToStyleRuleTest >> propertyIndex [ 

	^ propertyIndex 
]

{ #category : #running }
ToStyleRuleTest >> setUp [ 

	super setUp.
	propertyIndex := ToPropertyIndex new recordAll: ToStyleSheet propertyList; yourself.

]

{ #category : #tests }
ToStyleRuleTest >> testNewStyleRuleFromSelector [

	".button:initial {
		background: blue;
		border: red;
	}"
	(ToStyleClassSelector new styleClass: #button)
		event: ToInitialLookEvent
		style: [ :sr |
			sr
				property: (self propertyIndex propertyNamed: #background)
				value: Color blue.
			sr
				property: (self propertyIndex propertyNamed: #border)
				value: Color red ]
]
