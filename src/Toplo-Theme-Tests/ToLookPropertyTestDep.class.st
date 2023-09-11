"
A ToLookPropertyTest is a test class for testing the behavior of ToLookProperty
"
Class {
	#name : #ToLookPropertyTestDep,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look-Dep'
}

{ #category : #'background property' }
ToLookPropertyTestDep >> testBackgroundProperty [

	| w prop  |
	w := ToElement new.
	prop := ToBackgroundPropertyDep new.
	prop update: w withValue: Color blue.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #'background property' }
ToLookPropertyTestDep >> testPropDef [

	| w propDef |
	w := ToElement new.
	propDef := ToPropertyDefinition new name: #background; updater: [ :e :v | e background: v ]; yourself.
	propDef update: w withValue: (ToPropertyAdapter new value: Color blue).
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #'general property' }
ToLookPropertyTestDep >> testWithValuable [

	| w prop |
	w := ToElement new.
	prop := ToLookPropertyUpdaterDep new.
	prop update: w withValuable: [ :e | e background: Color blue ].
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]
