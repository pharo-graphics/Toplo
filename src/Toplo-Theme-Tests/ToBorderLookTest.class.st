"
A ToBorderLookTest is a test class for testing the behavior of ToBorderLook
"
Class {
	#name : #ToBorderLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToBorderLookTest >> testNoBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: ToBorderLook new.
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w border equals: BlBorder empty
]

{ #category : #tests }
ToBorderLookTest >> testWithBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToBorderLook new
				disabledStateValue:  (BlBorder paint: Color red);
				initialStateValue: (BlBorder paint: Color gray);
				hoveredStateValue: (BlBorder paint: Color blue);
				pressedStateValue: (BlBorder paint: Color white)).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w border width equals: 1.
	self assert: w border paint color equals: Color gray.
	w switchToSkinState: ToDisabledState new.
	self assert: w border paint color equals: Color red.
	w switchToSkinState: ToPressedState new.
	self assert: w border paint color equals: Color white.
	w switchToSkinState: ToHoveredState new.
	self assert: w border paint color equals: Color blue
]
