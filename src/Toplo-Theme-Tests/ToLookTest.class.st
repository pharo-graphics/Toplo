"
A ToLookTest is a test class for testing the behavior of ToLook
"
Class {
	#name : #ToLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #background }
ToLookTest >> changeBackgroundWithAnimation: anAnimation on: anElement with: aBackground [

	anElement isDisabled ifTrue: [
		^ anElement switchToSkinState: ToDisabledState new ].
	anAnimation onFinishedDo: [
		anElement background: aBackground ].
	anElement addAnimation: anAnimation
]

{ #category : #background }
ToLookTest >> changeBackgroundWithColorTransitionOn: anElement from: aFirstColor to: aSecondColor [

	| animation |

	animation := BlColorTransition new
		             duration: 200 milliSeconds;
		             from: aFirstColor;
		             to: aSecondColor;
		             onStepDo: [ :c :e | e background: c ].
	self changeBackgroundWithAnimation: animation on: anElement with: aSecondColor.
	^ animation

]

{ #category : #background }
ToLookTest >> changeBackgroundWithColorTransitionOn: anElement with: aColor [

	| currentBackground currentColor animation |
	aColor ifNil: [^ self ].
	currentBackground := anElement background.
	(currentBackground isColorBackground or: [currentBackground isTransparent ]) ifFalse: [
		^ anElement background: aColor ].
	currentColor := currentBackground isTransparent ifTrue: [Color transparent] ifFalse: [currentBackground paint color].
	animation := BlColorTransition new
		             duration: 200 milliSeconds;
		             from: currentColor;
		             to: aColor;
		             onStepDo: [ :c :e | e background: c ].
	self changeBackgroundWithAnimation: animation on: anElement with: aColor.
	^ animation

]

{ #category : #background }
ToLookTest >> testChangeBackground [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLook forBackground 
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

	| w skin look animation |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLook new
		        applyWith: [ :e :v |
			        animation := self
				                     changeBackgroundWithColorTransitionOn: e
				                     with: v ];
		        whenInstalled: [ :e | e background: Color yellow ];
		        initialValue: [ :e | BlBackground paint: Color red ];
		        disabledValue: [ :e | BlBackground paint: Color gray ];
		        pressedValue: [ :e | BlBackground paint: Color blue ];
		        hoveredValue: [ :e | BlBackground paint: Color white ];
		        yourself.
	skin addLook: look.
	w withSkin: skin.

	w switchToSkinState: ToInstallState new.
	self assert: animation isNil.
	self assert: w background paint color equals: Color yellow.

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
	skin addLook: (ToLook forBackground 
			 whenInitialized: [ :e | e background: Color red ];
			 disabledValue: Color gray ;
			 pressedValue: Color blue ;
			 hoveredValue: Color white ;
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
			 whenInitialized: Color red;
			 whenDisabled: Color gray;
			 whenPressed: Color blue;
			 whenHovered: Color white;
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
			 whenDisabled: (BlBorder paint: Color red);
			 whenInitialized: (BlBorder paint: Color gray);
			 whenHovered: (BlBorder paint: Color blue);
			 whenPressed: (BlBorder paint: Color white);
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
			 whenInstalled: (ToStateUpdater new value: switch);
			 whenInitialized: (ToStateUpdater new value: switch);
			 whenDisabled: (ToStateUpdater new value: switch);
			 whenClicked: (ToStateUpdater new value: switch);
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
		        whenDisabled: (newForm value mapColor: colorToMap to: Color gray);
		        whenInitialized: (newForm value mapColor: colorToMap to: Color blue);
		        whenHovered: (newForm value mapColor: colorToMap to: Color red);
		        whenPressed: (newForm value mapColor: colorToMap to: Color yellow);
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
		        applyWith: [ :e :v | c := v. e withInnerFormDo: [ :form | e innerImage: (form collectColors: [ :color | v alpha: color alpha ]) ] ifNone: [  ] ];
		        whenInstalled: Color white;
		        whenDisabled: Color gray;
		        whenInitialized: Color black;
		        whenHovered: Color blue;
		        whenPressed: Color red;
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
		        applyWith: [ :e :v | c := v. e withInnerFormDo: [ :f | e innerImage: (f collectColors: [ :color | v alpha: color alpha ]) ] ifNone: [  ] ];
		        whenDisabled: Color gray;
		        whenInitialized: Color black;
		        whenHovered: Color blue;
		        whenPressed: Color red;
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
		        whenInstalled: [ :e |
			        e layout: BlLinearLayout new.
			        e layout leftToRight.
			        e layout beHorizontal.
			        e layout interspace: 5 ];
		        whenHovered: [ :e |
			        e layout rightToLeft.
			        e layout interspace: 10 ];
		        whenLeaved: [ :e |
			        e layout leftToRight.
			        e layout interspace: 5 ];
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
	self assert: w layout interspace equals: 5
]

{ #category : #'size - margin - padding' }
ToLookTest >> testChangeSizePaddingMargin [

	| w skin sizeLook marginLook paddingLook |
	w := ToElement new.
	skin := ToWidgetSkin new.
	sizeLook := ToLook new applyWith: [ :e :s | e size: s ];
			whenInitialized: 10 @ 20;
			yourself.
	marginLook := ToLook new applyWith: [ :e :s | e margin: s ];
			whenInitialized: (BlInsets all: 3);
			yourself.
	paddingLook := ToLook new applyWith: [ :e :s | e padding: s ];
			whenInitialized: (BlInsets all: 4);
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

{ #category : #'size - margin - padding' }
ToLookTest >> testChangeSizePaddingMargin2 [

	| w skin sizeLook marginLook paddingLook |
	w := ToElement new.
	skin := ToWidgetSkin new.
	sizeLook := ToLook new
			whenInitialized: [:e | e size: 10 @ 20];
			yourself.
	marginLook := ToLook new
			whenInitialized: [:e | e margin: (BlInsets all: 3) ];
			yourself.
	paddingLook := ToLook new 
			whenInitialized: [:e | e padding: (BlInsets all: 4)];
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
			 whenDisabled: (BlTextAttributesBuilder new background: Color gray; yourself);
			 whenInitialized: (BlTextAttributesBuilder new background: Color white; yourself);
			 whenHovered: (BlTextAttributesBuilder new background: Color yellow; yourself);
			 whenPressed: (BlTextAttributesBuilder new background: Color red; yourself);
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

{ #category : #'label text attributes' }
ToLookTest >> testChangeTextAttributesWithAtributeBuilder1 [

	| w skin firstCharFirstAttr |
	w := ToLabel new text: 'A'.
	skin := ToWidgetSkin new.
	skin addLook: (ToLook forTextAttributes 
			 whenDisabled: (BlTextAttributesBuilder new background: Color gray; yourself);
			 whenInitialized: (BlTextAttributesBuilder new background: Color white; yourself);
			 whenHovered: (BlTextAttributesBuilder new background: Color yellow; yourself);
			 whenPressed: (BlTextAttributesBuilder new background: Color red; yourself);
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

{ #category : #'label text attributes' }
ToLookTest >> testChangeTextAttributesWithAtributeBuilder2 [

	| w skin firstCharFirstAttr attrBuilder |
	attrBuilder := BlTextAttributesBuilder new.
	w := ToLabel new text: 'A'.
	skin := ToWidgetSkin new.
	skin addLook: ((ToLook forTextForegroundWithBuilder: attrBuilder)
			 whenDisabled: Color gray;
			 whenInitialized: Color white;
			 whenHovered: Color yellow;
			 whenPressed: Color red;
			 yourself).
	w withSkin: skin.

	w switchToSkinState: ToInitialState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextForegroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color white.

	w switchToSkinState: ToDisabledState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextForegroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color gray.

	w switchToSkinState: ToPressedState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextForegroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color red.

	w switchToSkinState: ToHoveredState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextForegroundAttribute).
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
