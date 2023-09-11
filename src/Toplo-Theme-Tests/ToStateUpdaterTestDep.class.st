"
A ToStateUpdaterTest is a test class for testing the behavior of ToStateUpdater
"
Class {
	#name : #ToStateUpdaterTestDep,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look-Dep'
}

{ #category : #tests }
ToStateUpdaterTestDep >> testWithStateUpdater [

	| w prop stateUpdater |
	w := ToElement new.
	prop := ToLookPropertyUpdaterDep new.
	stateUpdater := ToElementAdapter new valuable: [ :e | e background: Color blue ].
	stateUpdater update: prop on: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToStateUpdaterTestDep >> testWithStateValueAndObjet [

	| w prop stateValue |
	w := ToElement new.
	stateValue := ToPropertyAdapter new value: Color blue.
	prop := ToBackgroundPropertyDep new.
	stateValue update: prop on: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]

{ #category : #tests }
ToStateUpdaterTestDep >> testWithStateValueAndValuable [

	| w prop stateValue |
	w := ToElement new.
	stateValue := ToPropertyAdapter new value: [:e | Color blue].
	prop := ToBackgroundPropertyDep new.
	stateValue update: prop on: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue
]
