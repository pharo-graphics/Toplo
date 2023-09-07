"
A ToImageFormLookTest is a test class for testing the behavior of ToImageFormLook
"
Class {
	#name : #ToImageLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToImageLookTest >> testStateChange [

	| w skin look colorToMap newForm |
	
	newForm := [ ColorForm extent: 16 asPoint ].
	colorToMap := newForm value colorsUsed first.
	w := ToImage new.
	skin := ToWidgetSkin new.

	look := ToImageLook new
		  disabledStateValue: (newForm value mapColor: colorToMap to: Color gray);
		  initialStateValue: (newForm value mapColor: colorToMap to: Color blue);
		  hoveredStateValue: (newForm value mapColor: colorToMap to: Color red);
		  pressedStateValue: (newForm value mapColor: colorToMap to: Color yellow);
		  yourself.

	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.
	
	w switchToSkinState: ToInitialState new.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: Color blue ].
	
	w switchToSkinState: ToPressedState new.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: Color yellow ].
	
	w switchToSkinState: ToHoveredState new.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: Color red ].

	w switchToSkinState: ToDisabledState new.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: Color gray ]

]
