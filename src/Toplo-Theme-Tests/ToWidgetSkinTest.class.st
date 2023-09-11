"
A ToWidgetSkinTest is a test class for testing the behavior of ToWidgetSkin
"
Class {
	#name : #ToWidgetSkinTest,
	#superclass : #TestCase,
	#instVars : [
		'propertyDefinitionMap'
	],
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #running }
ToWidgetSkinTest >> newPropertyDefinitionMap [

	^ ToPropertyDefinitionMap new recordAll: self propertyDefinitions; yourself
]

{ #category : #tests }
ToWidgetSkinTest >> propertyDefinitionMap [

	^ propertyDefinitionMap
]

{ #category : #running }
ToWidgetSkinTest >> propertyDefinitions [

	^ {
		  (ToInstVarPropertyDefinition name: #background).
		  (ToInstVarPropertyDefinition name: #border).
		  (ToInstVarPropertyDefinition name: #size).
		  (ToInstVarPropertyDefinition name: #margin).
		  (ToInstVarPropertyDefinition name: #padding).
		  (ToExplicitPropertyDefinition
			   name: #'background-color'
			   reader: [ :e | e background paint color ]
			   writer: [ :e :v | e background: v ]).
		  (ToExplicitPropertyDefinition
			   name: #'checkable-icon-image'
			   reader: [ :e | e icon innerImage ]
			   writer: [ :e :v |
				   v removeFromParent.
				   e iconImage: v ]).
		  (ToInstVarPropertyDefinition name: #layout).
		  (ToExplicitPropertyDefinition
			   name: #'layout-direction'
			   reader: [ :e | e layout direction ]
			   writer: [ :e :v | e layout direction: v ]).
		  (ToExplicitPropertyDefinition
			   name: #'layout-orientation'
			   reader: [ :e | e layout orientation ]
			   writer: [ :e :v | e layout orientation: v ]).
		  (ToExplicitPropertyDefinition
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ]) }
]

{ #category : #running }
ToWidgetSkinTest >> setUp [ 

	super setUp.
	propertyDefinitionMap := self newPropertyDefinitionMap
]

{ #category : #tests }
ToWidgetSkinTest >> testChangeBackground [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #background)
		when: ToInstallLookEvent value: (BlBackground paint: Color yellow);
		when: ToInitialLookEvent value: (BlBackground paint: Color red);
		when: ToDisabledLookEvent value: (BlBackground paint: Color gray);
		when: ToPressedLookEvent value: (BlBackground paint: Color blue);
		when: ToHoveredLookEvent value: (BlBackground paint: Color white);
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeBackground2 [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #background)
		when: ToInstallLookEvent value: (BlBackground paint: Color yellow);
		when: ToInitialLookEvent value: (BlBackground paint: Color red);
		when: ToDisabledLookEvent value: (BlBackground paint: Color gray);
		when: ToPressedLookEvent value: (BlBackground paint: Color blue);
		when: ToHoveredLookEvent value: (BlBackground paint: Color white);
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeBackgroundUseOnlyTheLastSubscriptionOfAnEventClass [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #background)
		when: ToInstallLookEvent value: (BlBackground paint: Color yellow);
		when: ToInitialLookEvent value: (BlBackground paint: Color red);
		when: ToDisabledLookEvent value: (BlBackground paint: Color gray);
		when: ToPressedLookEvent value: (BlBackground paint: Color blue);
		" ToHoveredLookEvent used 2 times -> only the last remaains "
		when: ToHoveredLookEvent value: (BlBackground paint: Color white);
		when: ToHoveredLookEvent value: (BlBackground paint: Color brown);
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
	self assert: w background paint color equals: Color brown
]

{ #category : #tests }
ToWidgetSkinTest >> testChangeBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: ((self propertyDefinitionMap lookUpdaterForPropertyNamed: #border )
			 when: ToDisabledLookEvent value: (BlBorder paint: Color red);
			 when: ToInitialLookEvent value: (BlBorder paint: Color gray);
			 when: ToHoveredLookEvent value: (BlBorder paint: Color blue);
			 when: ToPressedLookEvent value: (BlBorder paint: Color white);
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeCheckableIcon [

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

	skin addLook: ((self propertyDefinitionMap lookUpdaterForPropertyNamed: #'checkable-icon-image')
			 when: ToInstallLookEvent value:  switch;
			when: ToInitialLookEvent value:  switch;
			when: ToDisabledLookEvent value:  switch;
			when: ToClickedLookEvent value:  switch;
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeImage [

	| w skin look colorToMap newForm |
	newForm := [ ColorForm extent: 16 asPoint ].
	colorToMap := newForm value colorsUsed first.
	w := ToImage new.
	skin := ToWidgetSkin new.

	look := (ToLookUpdater new property: (ToInstVarPropertyDefinition new name: #innerImage))
			 when: ToDisabledLookEvent value: (newForm value mapColor: colorToMap to: Color gray);
			 when: ToInitialLookEvent value: (newForm value mapColor: colorToMap to: Color blue);
			 when: ToHoveredLookEvent value: (newForm value mapColor: colorToMap to: Color red);
			 when: ToPressedLookEvent value: (newForm value mapColor: colorToMap to: Color yellow);
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeImageForm [

	| w skin look c prop |
	w := ToImage new.
	skin := ToWidgetSkin new.
	prop := ToExplicitPropertyDefinition new
		        name: #'inner-form';
		        reader: [ :e | e innerForm ];
		        writer: [ :e :v |
			        c := v.
			        e
				        withInnerFormDo: [ :form |
					        e innerImage:
							        (form collectColors: [ :color | v alpha: color alpha ]) ]
				        ifNone: [  ] ].
	look := (ToLookUpdater new property: prop)
		        when: ToInstallLookEvent value: Color white;
		        when: ToDisabledLookEvent value: Color gray;
		        when: ToInitialLookEvent value: Color black;
		        when: ToHoveredLookEvent value: Color blue;
		        when: ToPressedLookEvent value: Color red;
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeLinearLayout [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToLookUpdater new
		        when: ToInstallLookEvent  do: [ :e |
			        e layout: BlLinearLayout new.
			        e layout leftToRight.
			        e layout beHorizontal.
			        e layout interspace: 5 ];
		        when: ToHoveredLookEvent do: [ :e |
			        e layout rightToLeft.
			        e layout interspace: 10 ];
		        when: ToLeavedLookEvent do: [ :e |
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeLinearLayout2 [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := self propertyDefinitionMap lookUpdaterForPropertyNamed: #layout.
	look
		when: ToInstallLookEvent value: BlLinearLayout new;
		with: {
				((self propertyDefinitionMap lookUpdaterForPropertyNamed: #'layout-direction')
					 when: ToInstallLookEvent value: BlLayoutDirection leftToRight;
					 when: ToHoveredLookEvent value: BlLayoutDirection rightToLeft;
					 when: ToLeavedLookEvent value: BlLayoutDirection leftToRight).
				((self propertyDefinitionMap lookUpdaterForPropertyNamed: #'layout-orientation')
					 when: ToInstallLookEvent value: BlLinearLayoutHorizontalOrientation new).
				((self propertyDefinitionMap lookUpdaterForPropertyNamed: #'layout-interspace')
					 when: ToInstallLookEvent value: 5;
					 when: ToHoveredLookEvent value: 10;
					 when: ToLeavedLookEvent value: 5) }.
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeSizePaddingMargin2 [

	| w skin sizeLook marginLook paddingLook |
	w := ToElement new.
	skin := ToWidgetSkin new.
	sizeLook := ToLookUpdater new
			when: ToInitialLookEvent do: [ :e | e size: 10 @ 20 ];
			yourself.
	marginLook := ToLookUpdater new
			when: ToInitialLookEvent do: [ :e | e margin: (BlInsets all: 3) ];
			yourself.
	paddingLook := ToLookUpdater new 
			when: ToInitialLookEvent do: [ :e | e padding: (BlInsets all: 4)];
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeSizePaddingMarginWithProperty [

	| w skin sizeLook marginLook paddingLook |
	w := ToElement new.
	skin := ToWidgetSkin new.
	sizeLook := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #size)
			when: ToInitialLookEvent value: 10 @ 20;
			yourself.
	marginLook := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #margin)
			when: ToInitialLookEvent value: (BlInsets all: 3);
			yourself.
	paddingLook := (self propertyDefinitionMap lookUpdaterForPropertyNamed: #padding)
			when: ToInitialLookEvent value: (BlInsets all: 4);
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

{ #category : #tests }
ToWidgetSkinTest >> testChangeTextAttributesWithAtributeBuilder [

	| w skin firstCharFirstAttr prop |
	w := ToLabel new text: 'A'.
	skin := ToWidgetSkin new.
	prop := ToExplicitPropertyDefinition new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: v attributes.
		e textChanged ].
	skin addLook: ((ToLookUpdater new property: prop)
			 when: ToDisabledLookEvent value: (BlTextAttributesBuilder new
					  background: Color gray;
					  yourself);
			 when: ToInitialLookEvent value: (BlTextAttributesBuilder new
				  background: Color white;
				  yourself);
			 when: ToHoveredLookEvent value: (BlTextAttributesBuilder new
				  background: Color yellow;
				  yourself);
			 when: ToPressedLookEvent value: (BlTextAttributesBuilder new
				  background: Color red;
				  yourself);
			 yourself).
	w withSkin: skin.

	w switchToSkinState: ToInitialState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color white.

	w switchToSkinState: ToDisabledState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color gray.

	w switchToSkinState: ToPressedState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color red.

	w switchToSkinState: ToHoveredState new.
	firstCharFirstAttr := (w text attributesAt: 1) first.
	self assert: (firstCharFirstAttr isKindOf: BlTextBackgroundAttribute).
	self assert: firstCharFirstAttr paint equals: Color yellow
]

{ #category : #tests }
ToWidgetSkinTest >> testNoBackgroundColor [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLookUpdater new
			 when: ToInstallLookEvent
			 do: [ :e | e background: BlBackground transparent ];
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint isNil
]

{ #category : #tests }
ToWidgetSkinTest >> testNoBorder [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: (ToLookUpdater new
			 when: ToInstallLookEvent do: [ :e | e border: BlBorder empty ];
			 yourself).
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w border equals: BlBorder empty
]

{ #category : #tests }
ToWidgetSkinTest >> testWithBackgroundColorAnimation [

	| w skin look animation |
	w := ToElement new.
	skin := ToWidgetSkin new.
	animation := ToColorTransitionAnimation new.
	look := self propertyDefinitionMap lookUpdaterForPropertyNamed: #'background-color'.
	look
		when: ToInstallLookEvent value: Color white;
		when: ToHoveredLookEvent value: Color black animation: animation;
		when: ToLeavedLookEvent value: Color white animation: animation.

	skin addLook: look.

	w withSkin: skin.

	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color white.

	w switchToSkinState: ToHoveredState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color black.

		w switchToSkinState: ToLeavedState new.
		animation onFinishedDo: [
			self assert: w background paint color equals: Color white ] ]
]
