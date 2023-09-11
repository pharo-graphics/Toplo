"
A ToWidgetSkinTest is a test class for testing the behavior of ToWidgetSkin
"
Class {
	#name : #ToWidgetSkinTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #tests }
ToWidgetSkinTest >> testChangeBackground [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := (ToLookUpdater new property: (ToPropertyDefinition propertyNamed: #background) )
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
	look := (ToLookUpdater forPropertyNamed: #background)
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
	look := ToLookUpdater forPropertyNamed: #layout.
	look
		when: ToInstallLookEvent value: BlLinearLayout new;
		with: {
				((ToLookUpdater forPropertyNamed: #'layout-direction')
					 when: ToInstallLookEvent value: BlLayoutDirection leftToRight;
					 when: ToHoveredLookEvent value: BlLayoutDirection rightToLeft;
					 when: ToLeavedLookEvent value: BlLayoutDirection leftToRight).
				((ToLookUpdater forPropertyNamed: #'layout-orientation')
					 when: ToInstallLookEvent value: BlLayoutOrientation horizontal).
				((ToLookUpdater forPropertyNamed: #'layout-interspace')
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
ToWidgetSkinTest >> testWithBackgroundColorAnimation [

	| w skin look animation |
	w := ToElement new.
	skin := ToWidgetSkin new.
	animation := ToColorTransitionAnimation new.
	look := ToLookUpdater forPropertyNamed: #'background-color'.
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
		self assert: w background paint color equals: Color black ].

	w switchToSkinState: ToLeavedState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color white ]
]
