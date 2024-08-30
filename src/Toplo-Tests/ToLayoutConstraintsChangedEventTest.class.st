"
A ToLayoutConstraintsChangedEventTest is a test class for testing the behavior of ToLayoutConstraintsChangedEvent
"
Class {
	#name : #ToLayoutConstraintsChangedEventTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToLayoutConstraintsChangedEventTest >> test [

	| bcpt cpt e |
	e := ToElement new.
	cpt := 0.
	e addEventHandler: (BlEventHandler
			 on: BlLayoutResizerChangedEvent
			 do: [ cpt := cpt + 1 ]).
	bcpt := cpt.
	e exact: 10 @ 10.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e fitContent.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e fitContentLimited.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e hExact: 20.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e hFitContent.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e hFitContentLimited.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e hMatchParent.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e matchParent.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e vExact: 20.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e vFitContent.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e vFitContentLimited.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	e vMatchParent.
	self assert: cpt equals: bcpt + 1
]
