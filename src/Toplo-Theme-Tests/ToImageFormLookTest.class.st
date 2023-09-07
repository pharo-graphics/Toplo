"
A ToFlatImageFormLookTest is a test class for testing the behavior of ToFlatImageFormLook
"
Class {
	#name : #ToImageFormLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToImageFormLookTest >> testStateChange [

	| w skin look form c |
	form := (ColorForm extent: 16 asPoint).
	w := ToImage new innerImage: form.
	skin := ToWidgetSkin new.

	look := ToImageFormLook new
		  disabledStateValue: [ :e | c := Color gray ];
		  initialStateValue: [ :e | c := Color black ];
		  hoveredStateValue: [ :e | c := Color blue ];
		  pressedStateValue: [ :e | c := Color red ];
		  yourself.
	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.
	
	w switchToSkinState: ToInitialState new.
	self assert: c equals: Color black.

	w switchToSkinState: ToPressedState new.
	self assert: c equals: Color red.

	w switchToSkinState: ToHoveredState new.
	self assert: c equals: Color blue.

	w switchToSkinState: ToDisabledState new.
	self assert: c equals: Color gray.

]

{ #category : #tests }
ToImageFormLookTest >> testWithMapColor [

	| w skin look form c |
	form := ColorForm extent: 16 asPoint.
	w := ToImage new innerImage: form.
	skin := ToWidgetSkin new.

	look := ToImageFormLook new
		        changeFormBlock: [ :e :color |
			        e withInnerFormDo: [ :f |
					        e innerImage: (f copy mapColor: f colorsUsed first to: color) ] ];
		        disabledStateValue: [ :e | c := Color gray ];
		        initialStateValue: [ :e | c := Color black ];
		        hoveredStateValue: [ :e | c := Color blue ];
		        pressedStateValue: [ :e | c := Color red ];
		        yourself.
	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.

	w switchToSkinState: ToInitialState new.
	self assert: c equals: Color black.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: c ].

	w switchToSkinState: ToPressedState new.
	self assert: c equals: Color red.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: c ].

	w switchToSkinState: ToHoveredState new.
	self assert: c equals: Color blue.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: c ].

	w switchToSkinState: ToDisabledState new.
	self assert: c equals: Color gray.
	w withInnerFormDo: [ :f | self assert: f colorsUsed first equals: c ].

]
