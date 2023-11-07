"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : 'ToStyleSheetSkinTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'writeablePropertyIndex',
		'space'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'running' }
ToStyleSheetSkinTest >> setUp [

	super setUp.
	space := self newTestingSpace.
	writeablePropertyIndex := ToPropertyIndex new.
	writeablePropertyIndex addAllProperties: self writablePropertyList.
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testPropertyWriterOrderMatter [

	| w skin layoutDirectionProp layoutProp layoutWriter directionWriter |
	w := ToElement new toTheme: ToBeeLightTheme new.
	space root addChild: w.
	w layout: BlBasicLayout new.
	skin := ToBeeSkin new.
	layoutDirectionProp := self writablePropertyIndex propertyNamed: #'layout-direction'.
	layoutProp := self writablePropertyIndex propertyNamed: #layout.
	directionWriter := ToPropertyWriter new
		                   eventClass: ToInitialLookEvent;
		                   property: layoutDirectionProp;
		                   value: BlLayoutDirection rightToLeft;
		                   yourself.
	layoutWriter := ToPropertyWriter new
		                eventClass: ToInitialLookEvent;
		                property: layoutProp;
		                value: BlLinearLayout new;
		                yourself.
	skin writers: {
			directionWriter.
			layoutWriter }.
	
	" Since checkSkinInstallation will switch to ToInstallState "
	" the installation will fail because the widget layout (not a BlLinearLayout) does not understand #direction:"
	w defaultSkin: skin.
	w requestSkin.
	w applySkinInstaller.
	self
		should: [ w updateStyles ]
		raise: MessageNotUnderstood.

	" Now change writers order and it should be ok "
	skin writers: {
			layoutWriter.
			directionWriter }.

	w enqueueSkinState: ToInitialState new.
	w updateStyles.
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isRightToLeft
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testSupplementWriter [

	| w skin backgroundProp borderProp borderBuilder |
	w := ToElement new.
	space root addChild: w.
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
	w defaultSkin: skin.
	w applySkinInstaller.
	w updateStyles.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color black.
	self assert: w border style dashArray equals: #( 4 5 )
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithAnimationOn2EventClasses [

	| w skin prop animation |
	w := ToElement new.
	space root addChild: w.
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

	w defaultSkin: skin.
	w requestSkin.
	w applySkinInstaller.
	w updateStyles.

	self assert: w background paint color equals: Color white.

	w enqueueSkinState: ToHoveredState new.
	animation onFinishedDo: [
		self assert: w background paint color equals: Color black.

		w enqueueSkinState: ToLeavedState new.
		animation onFinishedDo: [
			self assert: w background paint color equals: Color white ] ]
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithNoWriter [

	| w skin paint |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	w defaultSkin: skin.
	paint := w background paint.
	w applySkinInstaller.
	w updateStyles.

	self assert: w background paint equals: paint
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWriters [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
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
	w defaultSkin: skin.
	w applySkinInstaller.
	w updateStyles.

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWritersTwoEventClasses [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
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
	w defaultSkin: skin.
	w applySkinInstaller.
	w updateStyles.

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color red
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWriters [

	| w skin prop propWriter |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin writers: { propWriter }.
	self assert: skin writers size equals: 1.
	self assert: skin writers first identicalTo: propWriter.
	w defaultSkin: skin.
	w applySkinInstaller.
	w updateStyles.

	self assert: w background paint color equals: Color blue
]

{ #category : 'running' }
ToStyleSheetSkinTest >> writablePropertyIndex [

	^ writeablePropertyIndex
]

{ #category : 'running' }
ToStyleSheetSkinTest >> writablePropertyList [

	^ ToStyleSheet defaultWritablePropertyList
]
