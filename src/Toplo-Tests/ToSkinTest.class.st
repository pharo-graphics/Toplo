"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToSkinTest,
	#superclass : #TestCase,
	#instVars : [
		'writeablePropertyIndex'
	],
	#category : 'Toplo-Tests-Core-Skin'
}

{ #category : #running }
ToSkinTest >> setUp [

	super setUp.
	writeablePropertyIndex := ToPropertyIndex new.
	writeablePropertyIndex addAllProperties: self writablePropertyList.
]

{ #category : #'test with accessors' }
ToSkinTest >> testPropertyWriterOrderMatter [

	| w skin layoutDirectionProp layoutProp layoutWriter directionWriter |
	w := ToElement new toTheme: ToBeeLightTheme new.
	w layout: BlBasicLayout new.
	skin := ToBeeSkin new.
	layoutDirectionProp := self writablePropertyIndex propertyNamed: #'layout-direction'.
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

	
	" Since checkSkinInstallation will switch to ToInstallState "
	" the installation will fail because the widget layout (not a BlLinearLayout) does not understand #direction:"
	w requestSkin: skin.
	w applySkinInstaller.
	self
		should: [ w applySkinStates ]
		raise: MessageNotUnderstood.

	" Now change writers order and it should be ok "
	skin writers: {
			layoutWriter.
			directionWriter }.

	w addNextSkinState: ToInstallState new.
	 w applySkinStates.
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isRightToLeft
]

{ #category : #'test with accessors' }
ToSkinTest >> testSupplementWriter [

	| w skin backgroundProp borderProp borderBuilder |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
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
	w requestSkin: skin.
	w applySkinInstaller.
	w applySkinStates.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color black.
	self assert: w border style dashArray equals: #( 4 5 )
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithAnimationOn2EventClasses [

	| w skin prop animation |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
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

	w requestSkin: skin.
	w applySkinInstaller.
	w applySkinStates.

	self assert: w background paint color equals: Color white.

	w addNextSkinState: ToHoveredState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color black.

		w addNextSkinState: ToLeavedState new.
		animation onFinishedDo: [
			self assert: w background paint color equals: Color white ] ]
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithNoWriter [

	| w skin paint |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
	w requestSkin: skin.
	paint := w background paint.
	w applySkinInstaller.
	w applySkinStates.

	self assert: w background paint equals: paint
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithOneWriter [

	| w skin prop propWriter |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin writers: { propWriter }.
	w requestSkin: skin.
	w applySkinInstaller.
	w applySkinStates.

	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithTwoWriters [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
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
	w requestSkin: skin.
	w applySkinInstaller.
	w applySkinStates.

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithTwoWritersTwoEventClasses [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	skin := ToStyleSheetSkin new.
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
	w requestSkin: skin.
	w applySkinInstaller.
	w applySkinStates.

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
