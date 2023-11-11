"
A ToEnablementChangedEventTest is a test class for testing the behavior of ToEnablementChangedEvent
"
Class {
	#name : #ToEnablementChangedEventTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core'
}

{ #category : #tests }
ToEnablementChangedEventTest >> testEnablement [

	| cpt e |
	e := ToElement new.
	cpt := 0.
	e when: ToEnablementChangedEvent do: [ cpt := cpt + 1 ].
	self assert: e isEnabled.
	e enabled: true.
	self assert: cpt equals: 0.
	e enabled: false.
	self assert: cpt equals: 1.
	e enabled: false.
	self assert: cpt equals: 1
]
