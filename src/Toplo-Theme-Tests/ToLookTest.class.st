"
A ToLookTest is a test class for testing the behavior of ToLook
"
Class {
	#name : #ToLookTest,
	#superclass : #TestCase,
	#instVars : [
		'animation'
	],
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #background }
ToLookTest >> changeBackgroundWithAnimationOn: anElement value: aBackground [

	| currentBackground currentColor newColor |
	animation := nil.
	aBackground ifNil: [^ self ].
	currentBackground := anElement background.
	aBackground isColorBackground ifFalse: [
		^ anElement background: aBackground ].
	anElement isDisabled ifTrue: [
		^ anElement switchToSkinState: ToDisabledState new ].
	(currentBackground isColorBackground or: [currentBackground isTransparent ]) ifFalse: [
		^ anElement background: aBackground ].
	currentColor := currentBackground isTransparent ifTrue: [Color transparent] ifFalse: [currentBackground paint color].
	newColor := aBackground paint color.
	animation := BlColorTransition new
		             duration: 200 milliSeconds;
		             from: currentColor;
		             to: newColor;
		             onStepDo: [ :aColor :e | e background: aColor ].
	animation onFinishedDo: [
		anElement background: aBackground.
		animation := nil ].
anElement addAnimation: animation
]

{ #category : #background }
ToLookTest >> testChangeBackground [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLook new
		        applyWith: [ :e :v | e background: v ];
		        installValue: (BlBackground paint: Color yellow);
		        initialValue: (BlBackground paint: Color red);
		        disabledValue: (BlBackground paint: Color gray);
		        pressedValue: (BlBackground paint: Color blue);
		        hoveredValue: (BlBackground paint: Color white);
		        yourself.
	skin addLook: look.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color yellow.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color red.
	w switchToSkinState: ToDisabledState new.
	self assert: w background paint color equals: Color gray.
	w switchToSkinState: ToPressedState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color white
]

{ #category : #background }
ToLookTest >> testChangeBackgroundWithAnimation [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLook new
		        applyWith: [ :e :v | self changeBackgroundWithAnimationOn: e value: v ];
		        installValue: (BlBackground paint: Color yellow);
		        initialValue: (BlBackground paint: Color red);
		        disabledValue: (BlBackground paint: Color gray);
		        pressedValue: (BlBackground paint: Color blue);
		        hoveredValue: (BlBackground paint: Color white);
		        yourself.
	skin addLook: look.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color yellow ].
	w switchToSkinState: ToInitialState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color red ].
	w switchToSkinState: ToDisabledState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color gray ].
	w switchToSkinState: ToPressedState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color blue ].
	w switchToSkinState: ToHoveredState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color white ]
]

{ #category : #background }
ToLookTest >> testChangeBackgroundWithClosure [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v | e background: v ];
			 initialValue: [ :e | Color red ];
			 disabledValue: [ :e | Color gray ];
			 pressedValue: [ :e | Color blue ];
			 hoveredValue: [ :e | Color white ];
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

{ #category : #background }
ToLookTest >> testChangeBackgroundWithColors [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v | e background: v ];
			 initialValue: Color red;
			 disabledValue: Color gray;
			 pressedValue: Color blue;
			 hoveredValue: Color white;
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

{ #category : #border }
ToLookTest >> testChangeBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v | e border: v asBlBorder ];
			 disabledValue: (BlBorder paint: Color red);
			 initialValue: (BlBorder paint: Color gray);
			 hoveredValue: (BlBorder paint: Color blue);
			 pressedValue: (BlBorder paint: Color white);
			 yourself).
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

{ #category : #'checkable icon' }
ToLookTest >> testChangeCheckableIcon [

	| w skin disabledImage checkedImage uncheckedImage indeterminateImage switch |
	w := ToCheckLookTestElement new.
	w initializeCheckable.
	w initializeDresser.
	w addDresser: ToCheckableButtonDresser new.
	skin := ToWidgetSkin new.
	
	disabledImage := BlElement new
		                 id: #disabled;
		                 yourself.
	checkedImage := BlElement new
		                id: #checked;
		                yourself.
	uncheckedImage := BlElement new
		                  id: #unchecked;
		                  yourself.
	indeterminateImage := BlElement new
		                      id: #indeterminate;
		                      yourself.
	switch := [ :e | 
	          e isDisabled
		          ifTrue: [ disabledImage ]
		          ifFalse: [
			          e isChecked
				          ifTrue: [ checkedImage ]
				          ifFalse: [
					          e isUnchecked
						          ifTrue: [ uncheckedImage ]
						          ifFalse: [ indeterminateImage ] ] ] ].

	skin addLook: (ToLook new
		        applyWith: [ :e :v | v removeFromParent. e iconImage: v ];
			 installValue: switch;
			 initialValue: switch;
			 disabledValue: switch;
			 clickedValue: switch;
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w switchToSkinState: ToInitialState new.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w disable.
	self assert: w icon innerImage identicalTo: disabledImage.
	w enable.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w checked: true.
	self assert: w icon innerImage identicalTo: checkedImage.
	w checked: false.
	self assert: w icon innerImage identicalTo: uncheckedImage.
	w checked: nil.
	self assert: w icon innerImage identicalTo: indeterminateImage.




	
	
	

]

{ #category : #'image form' }
ToLookTest >> testChangeImage [

	| w skin look colorToMap newForm |
	newForm := [ ColorForm extent: 16 asPoint ].
	colorToMap := newForm value colorsUsed first.
	w := ToImage new.
	skin := ToWidgetSkin new.

	look := ToLook new
		        applyWith: [ :e :v | e innerImage: v ];
		        disabledValue: (newForm value mapColor: colorToMap to: Color gray);
		        initialValue: (newForm value mapColor: colorToMap to: Color blue);
		        hoveredValue: (newForm value mapColor: colorToMap to: Color red);
		        pressedValue: (newForm value mapColor: colorToMap to: Color yellow);
		        yourself.

	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.

	w switchToSkinState: ToInitialState new.
	w withInnerFormDo: [ :f |
		self assert: f colorsUsed first equals: Color blue ].

	w switchToSkinState: ToPressedState new.
	w withInnerFormDo: [ :f |
		self assert: f colorsUsed first equals: Color yellow ].

	w switchToSkinState: ToHoveredState new.
	w withInnerFormDo: [ :f |
		self assert: f colorsUsed first equals: Color red ].

	w switchToSkinState: ToDisabledState new.
	w withInnerFormDo: [ :f |
		self assert: f colorsUsed first equals: Color gray ]
]

{ #category : #'image form' }
ToLookTest >> testChangeImageForm [

	| w skin look c |
	w := ToImage new.
	skin := ToWidgetSkin new.

	look := ToLook new
		        applyWith: [ :e :v | e withInnerFormDo: [ :form | e innerImage: (form collectColors: [ :color | v alpha: color alpha ]) ] ifNone: [  ] ];
		        installValue: [ :e | c := Color white ];
		        disabledValue: [ :e | c := Color gray ];
		        initialValue: [ :e | c := Color black ];
		        hoveredValue: [ :e | c := Color blue ];
		        pressedValue: [ :e | c := Color red ];
		        yourself.
	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.

	w switchToSkinState: ToInstallState new.
	self assert: c equals: Color white.

	w switchToSkinState: ToInitialState new.
	self assert: c equals: Color black.

	w switchToSkinState: ToPressedState new.
	self assert: c equals: Color red.

	w switchToSkinState: ToHoveredState new.
	self assert: c equals: Color blue.

	w switchToSkinState: ToDisabledState new.
	self assert: c equals: Color gray
]

{ #category : #'image form' }
ToLookTest >> testChangeImageFormWithMapColor [

	| w skin look form c |
	form := ColorForm extent: 16 asPoint depth: 32.
	w := ToImage new innerImage: form.
	skin := ToWidgetSkin new.

	look := ToLook new
		        applyWith: [ :e :v | e withInnerFormDo: [ :f | e innerImage: (f collectColors: [ :color | v alpha: color alpha ]) ] ifNone: [  ] ];
		        disabledValue: [ :e | c := Color gray ];
		        initialValue: [ :e | c := Color black ];
		        hoveredValue: [ :e | c := Color blue ];
		        pressedValue: [ :e | c := Color red ];
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

{ #category : #layout }
ToLookTest >> testChangeLinearLayout [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLook new
		        applyWith: [ :e :block | block value ];
		        installValue: [ :e |
			        [
			        e layout: BlLinearLayout new.
			        e layout leftToRight.
			        e layout beHorizontal.
			        e layout interspace: 5 ] ];
		        hoveredValue: [ :e |
			        [
			        e layout rightToLeft.
			        e layout interspace: 10 ] ];
		        leavedValue: [ :e |
			        [
			        e layout leftToRight.
			        e layout interspace: 5 ] ];
		        yourself.
	skin addLook: look.
	w withSkin: skin.

	w switchToSkinState: ToInstallState new.
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isLeftToRight.
	self assert: w layout isHorizontal.
	self assert: w layout interspace equals: 5.

	w switchToSkinState: ToHoveredState new.
	self assert: w layout direction isRightToLeft.
	self assert: w layout isHorizontal.
	self assert: w layout interspace equals: 10.
	
	w switchToSkinState: ToLeavedState new.
	self assert: w layout direction isLeftToRight.
	self assert: w layout isHorizontal.
	self assert: w layout interspace equals: 5.
]

{ #category : #'size - margin - padding' }
ToLookTest >> testChangeSizePaddingMargin [

	| w skin sizeLook marginLook paddingLook |
	w := ToElement new.
	skin := ToWidgetSkin new.
	sizeLook := ToLook new applyWith: [ :e :s | e size: s ];
			initialValue: 10 @ 20;
			yourself.
	marginLook := ToLook new applyWith: [ :e :s | e margin: s ];
			initialValue: (BlInsets all: 3);
			yourself.
	paddingLook := ToLook new applyWith: [ :e :s | e padding: s ];
			initialValue: (BlInsets all: 4);
			yourself.
	skin addLook: sizeLook.
	skin addLook: marginLook.
	skin addLook: paddingLook.
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w margin equals: (BlInsets all: 3).
	self assert: w padding equals: (BlInsets all: 4).
	" have to wait for the next layouting "
	self assert: w width equals: 0.
	self assert: w height equals: 0.
	w forceLayout.
	self assert: w width equals: 10.
	self assert: w height equals: 20.

]

{ #category : #'label text attributes' }
ToLookTest >> testChangeTextAttributesWithAtributeBuilder [

	| w skin firstCharFirstAttr |
	w := ToLabel new text: 'A'.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v |
				 e text attributes: v attributes.
				 e textChanged ];
			 disabledValue: (BlTextAttributesBuilder new background: Color gray; yourself);
			 initialValue: (BlTextAttributesBuilder new background: Color white; yourself);
			 hoveredValue: (BlTextAttributesBuilder new background: Color yellow; yourself);
			 pressedValue: (BlTextAttributesBuilder new background: Color red; yourself);
			 yourself).
	w withSkin: skin.
	
	w switchToSkinState: ToInitialState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: ( firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color white.

	w switchToSkinState: ToDisabledState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: ( firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color gray.

	w switchToSkinState: ToPressedState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: ( firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color red.
	
	w switchToSkinState: ToHoveredState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: ( firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color yellow
]

{ #category : #background }
ToLookTest >> testNoBackgroundColor [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v | e background: v ];
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint isNil
]

{ #category : #border }
ToLookTest >> testNoBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook new
			 applyWith: [ :e :v | e border: v asBlBorder ];
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w border equals: BlBorder empty
]
