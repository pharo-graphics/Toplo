"
A ToLayoutOrientationChangedEventTest is a test class for testing the behavior of ToLayoutOrientationChangedEvent
"
Class {
	#name : 'ToLayoutOrientationChangedEventTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToLayoutOrientationChangedEventTest >> test [

	| li cpt bcpt |
	li := ToLabeledIcon new.
	li beHorizontal.
	cpt := 0.
	li addEventHandler: (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ cpt := cpt + 1 ]).
	bcpt := cpt.
	li beVertical.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li beHorizontal.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li vertical: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li vertical: false.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li horizontal: false.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li horizontal: true.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li orientation: BlLinearLayoutVerticalOrientation new.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li orientation: BlLinearLayoutVerticalOrientation new.
	self assert: cpt equals: bcpt.
	bcpt := cpt.
	li orientation: BlLinearLayoutHorizontalOrientation new.
	self assert: cpt equals: bcpt + 1.
	bcpt := cpt.
	li orientation: BlLinearLayoutHorizontalOrientation new.
	self assert: cpt equals: bcpt
]
