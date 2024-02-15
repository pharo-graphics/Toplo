"
A ToLayoutDirectionChangedEventTest is a test class for testing the behavior of ToLayoutDirectionChangedEvent
"
Class {
	#name : #ToLayoutDirectionChangedEventTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core'
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
	li beLeftToRight.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li beRightToLeft.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li beLeftToRight.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li leftToRight: false.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li leftToRight: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li rightToLeft: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li rightToLeft: false.
	self assert: cpt equals: bcpt + 1
]
