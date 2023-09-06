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
				disabledPaint: [ :e | Color red ];
				initialPaint: [ :e | Color gray];
				hoverPaint: [ :e | Color blue];
				pressedPaint: [ :e | Color white ];
				width: [ :e | e toTheme lineWidth ];
				dashArray: [ :e | #(0 5) ]).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w border width equals: 1.
	self assert: w border style dashArray equals: #(0 5).
	self assert: w border paint color equals: Color gray.
	w switchToSkinState: ToDisabledState new.
	self assert: w border paint color equals: Color red.
	w switchToSkinState: ToPressedState new.
	self assert: w border paint color equals: Color white.
	w switchToSkinState: ToHoveredState new.
	self assert: w border paint color equals: Color blue
]
