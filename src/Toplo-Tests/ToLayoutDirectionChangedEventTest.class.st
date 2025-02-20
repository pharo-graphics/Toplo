"
A ToLayoutDirectionChangedEventTest is a test class for testing the behavior of ToLayoutDirectionChangedEvent
"
Class {
	#name : #ToLayoutDirectionChangedEventTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToLayoutDirectionChangedEventTest >> test [

	| li cpt bcpt |
	li := ToLabeledIcon new.
	li beRightToLeft.
	cpt := 0.
	li addEventHandler: (BlEventHandler
			 on: ToLayoutDirectionChangedEvent
			 do: [ cpt := cpt + 1 ]).
	bcpt := cpt.
	li beStartToEnd.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li beEndToStart.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li beStartToEnd.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li startToEnd: false.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li startToEnd: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li endToStart: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li endToStart: false.
	self assert: cpt equals: bcpt + 1
]
