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
ToStyleSheetSkinTest >> defaultWritablePropertyList [

	^ ToStyleSheet defaultWritablePropertyList
]

{ #category : 'running' }
ToStyleSheetSkinTest >> setUp [

	super setUp.
	space := self newTestingSpace.
	writeablePropertyIndex := ToPropertyIndex new.
	writeablePropertyIndex addAllProperties: self defaultWritablePropertyList.
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testPropertyWriterOrderMatter [

	| w skin layoutDirectionProp layoutProp layoutWriter directionWriter |
	w := ToElement new.
	space toTheme: ToStyleSheetTheme light.
	space root addChild: w.
	w layout: BlBasicLayout new.
	skin := ToBeeSkin new.
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
	skin propertyWriters: {
			directionWriter.
			layoutWriter }.

	" Since checkSkinInstallation will switch to ToInstallState "
	" the installation will fail because the widget layout (not a BlLinearLayout) does not understand #direction:"
	w defaultSkin: skin.
	w requestInstallSkin.
	" since applySkinInstaller will applyStyles "
	self should: [ w applySkinInstaller ] raise: MessageNotUnderstood.

	" Now change writers order and it should be ok "
	skin propertyWriters: {
			layoutWriter.
			directionWriter }.

	w skinStateQueue enqueueInstallStateForElement: w.
	w applyEnqueuedStates.
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isRightToLeft
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testPropertyWriters [

	| w skin prop propWriter |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin propertyWriters: { propWriter }.
	self assert: skin propertyWriters size equals: 1.
	self assert: skin propertyWriters first identicalTo: propWriter.
	w defaultSkin: skin.
	w applySkinInstaller.

	self assert: w background paint color equals: Color blue
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testSupplementWriter [

	| w skin backgroundProp borderProp borderBuilder |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	borderBuilder := BlBorderBuilder new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin propertyWriters: {
			(ToPropertyWriter new
				 eventClass: ToInstallLookEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: [ :e | Color yellow ];
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInstallLookEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color red;
						 build ] yourself).
			(ToPropertyWriter new
				 supplement: true;
				 eventClass: ToInstallLookEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color black;
						 dashArray: #( 4 5 );
						 build ] yourself) }.
	w defaultSkin: skin.
	w applySkinInstaller.
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

	skin propertyWriters: {
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToInstallLookEvent;
				 value: Color white;
				 yourself).
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToHoveredLookEvent;
				 value: Color black;
				 animation: animation;
				 yourself).
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToLeavedLookEvent;
				 value: Color white;
				 animation: animation;
				 yourself) }.

	w defaultSkin: skin.
	w requestInstallSkin.
	w applySkinInstaller.

	self assert: w background paint color equals: Color white.

	w enqueueSkinState:
		(ToTransientState lookEvent: ToHoveredLookEvent new).
	animation onFinishedDo: [ :x |
		self assert: w background paint color equals: Color black.

		w enqueueSkinState:
			(ToTransientState lookEvent: ToLeavedLookEvent new).
		animation onFinishedDo: [ :xx |
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

	self assert: w background paint equals: paint
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWriters [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin propertyWriters: {
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

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : 'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWritersTwoEventClasses [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin propertyWriters: {
			(ToPropertyWriter new
				 eventClass: ToInstallLookEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: Color yellow;
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInstallLookEvent;
				 property: borderProp;
				 value: Color red;
				 yourself) }.
	w defaultSkin: skin.
	w applySkinInstaller.

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color red
]

{ #category : 'running' }
ToStyleSheetSkinTest >> writablePropertyIndex [

	^ writeablePropertyIndex
]
