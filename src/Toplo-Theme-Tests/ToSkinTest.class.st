"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToSkinTest,
	#superclass : #TestCase,
	#instVars : [
		'writeablePropertyIndex'
	],
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #running }
ToSkinTest >> setUp [ 

	super setUp.
	writeablePropertyIndex := ToPropertyIndex new recordAll: self writablePropertyList; yourself
]

{ #category : #'test with accessors' }
ToSkinTest >> testPropertyWriterOrderMatter [

	| w skin layoutDirectionProp layoutProp layoutWriter directionWriter |
	w := ToElement new.
	w layout: BlBasicLayout new.
	skin := ToSkin new.
	layoutDirectionProp := self writablePropertyIndex propertyNamed:
		                       #'layout-direction'.
	layoutProp := self writablePropertyIndex propertyNamed: #layout.
	directionWriter := ToPropertyWriter new
		                   eventClass: ToInstallLookEvent;
		                   property: layoutDirectionProp;
		                   value: BlLayoutDirection rightToLeft;
		                   yourself.
	layoutWriter := ToPropertyWriter new
		                eventClass: ToInstallLookEvent;
		                property: layoutProp;
		                value: BlLinearLayout new;
		                yourself.
	skin writers: {
			directionWriter.
			layoutWriter }.

	w withSkin: skin.
	" the installation will fail because the widget layout (not a BlLinearLayout) does not understand #direction:"
	self
		should: [ w switchToSkinState: ToInstallState new ]
		raise: MessageNotUnderstood.

	" Now change writers order and it should be ok "
	skin writers: {
			layoutWriter.
			directionWriter }.
	w switchToSkinState: ToInstallState new.
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isRightToLeft
]

{ #category : #'test with accessors' }
ToSkinTest >> testSupplementWriter [

	| w skin backgroundProp borderProp borderBuilder |
	w := ToElement new.
	skin := ToSkin new.
	borderBuilder := BlBorderBuilder new.
	backgroundProp := self writablePropertyIndex propertyNamed: #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin writers: {
			(ToPropertyWriter new
				 eventClass: ToInitialLookEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: [ :e | Color yellow ];
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInitialLookEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color red;
						 build ] yourself).
			(ToPropertyWriter new
				 supplement: true;
				 eventClass: ToInitialLookEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color black;
						 dashArray: #( 4 5 );
						 build ] yourself) }.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint isNil.
	self assert: w border paint color equals: Color yellow.
	self assert: w border style dashArray equals: #(  ).
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color black.
	self assert: w border style dashArray equals: #( 4 5 )
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithAnimationOn2EventClasses [

	| w skin prop animation |
	w := ToElement new.
	skin := ToSkin new.
	animation := ToPropertyColorTransitionAnimation new.
	prop := self writablePropertyIndex propertyNamed: #'background-color'.

	skin writers: { 
		ToPropertyWriter new
			property: prop;
			eventClass: ToInstallLookEvent;
			value: Color white;
			yourself.
		ToPropertyWriter new
			property: prop;
			eventClass: ToHoveredLookEvent;
			value: Color black;
			animation: animation;
			yourself.
		ToPropertyWriter new
			property: prop;
			eventClass: ToLeavedLookEvent;
			value: Color white;
			animation: animation;
			yourself.
	
	 }.

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

{ #category : #'test with accessors' }
ToSkinTest >> testWithNoWriter [

	| w skin paint |
	w := ToElement new.
	skin := ToSkin new.
	w withSkin: skin.
	paint := w background paint.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint equals: paint
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithOneWriter [

	| w skin prop propWriter |
	w := ToElement new.
	skin := ToSkin new.
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin writers: { propWriter }.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithTwoWriters [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	skin := ToSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed: #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin writers: {
			(ToPropertyWriter new
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: Color yellow;
				 yourself) }.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithTwoWritersTwoEventClasses [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	skin := ToSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed: #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin writers: {
			(ToPropertyWriter new
				 eventClass: ToInitialLookEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: Color yellow;
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInitialLookEvent;
				 property: borderProp;
				 value: Color red;
				 yourself) }.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint isNil.
	self assert: w border paint color equals: Color yellow.
	w switchToSkinState: ToInitialState new.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color red
]

{ #category : #running }
ToSkinTest >> writablePropertyIndex [

	^ writeablePropertyIndex
]

{ #category : #running }
ToSkinTest >> writablePropertyList [

	^ ToStyleSheet defaultWritablePropertyList
]
