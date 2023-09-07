"
A ToBackgroundColorLookTest is a test class for testing the behavior of ToBackgroundColorLook
"
Class {
	#name : #ToBackgroundLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToBackgroundLookTest >> testNoBackgroundColor [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: ToBackgroundLook new.
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint isTransparent.

]

{ #category : #tests }
ToBackgroundLookTest >> testWithBackground [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToBackgroundLook new
			 initialStateValue: (BlBackground paint: Color red);
			 disabledStateValue: (BlBackground paint:Color gray);
			 pressedStateValue: (BlBackground paint:Color blue);
			 hoveredStateValue: (BlBackground paint:Color white);
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color red.
	w switchToSkinState: ToDisabledState new.
	self assert: w background paint color equals: Color gray.
	w switchToSkinState: ToPressedState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToBackgroundLookTest >> testWithClosure [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToBackgroundLook new
			 initialStateValue: [ :e | Color red ];
			 disabledStateValue: [ :e | Color gray ];
			 pressedStateValue: [ :e | Color blue ];
			 hoveredStateValue: [ :e | Color white ];
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color red.
	w switchToSkinState: ToDisabledState new.
	self assert: w background paint color equals: Color gray.
	w switchToSkinState: ToPressedState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToBackgroundLookTest >> testWithColors [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToBackgroundLook new
			 initialStateValue: Color red;
			 disabledStateValue: Color gray;
			 pressedStateValue: Color blue;
			 hoveredStateValue: Color white;
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color red.
	w switchToSkinState: ToDisabledState new.
	self assert: w background paint color equals: Color gray.
	w switchToSkinState: ToPressedState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color white
]
