"
A ToBackgroundColorLookTest is a test class for testing the behavior of ToBackgroundColorLook
"
Class {
	#name : #ToBackgroundColorLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToBackgroundColorLookTest >> testNoBackgroundColor [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: ToBackgroundColorLook new.
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint isTransparent
]

{ #category : #tests }
ToBackgroundColorLookTest >> testWithColors [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToBackgroundColorLook new
		  initialColor: [ :e | Color red ];
		  disabledColor: [ :e | Color gray ];
		  pressedColor: [ :e | Color blue ];
		  hoverColor: [ :e | Color white ];
		  yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color red.
	w switchToSkinState: ToDisabledState new.
	self assert: w background paint color equals: Color gray.
	w switchToSkinState: ToPressedState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color white.

]
