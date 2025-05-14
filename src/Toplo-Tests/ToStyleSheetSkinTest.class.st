"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToStyleSheetSkinTest,
	#superclass : #ToTestCaseWithSpace,
	#instVars : [
		'writeablePropertyIndex'
	],
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #running }
ToStyleSheetSkinTest >> defaultWritablePropertyList [

	^ ToStyleSheet defaultWritablePropertyList
]

{ #category : #running }
ToStyleSheetSkinTest >> setUp [

	super setUp.
	writeablePropertyIndex := ToPropertyIndex new.
	writeablePropertyIndex addAllProperties: self defaultWritablePropertyList.
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testPropertyWriterOrderMatter [

	| w skin layoutDirectionProp layoutProp layoutWriter directionWriter |
	w := ToElement new.
	w applySkinInstallerOnFirstRequest: false.
	space toTheme: ToStyleSheetTheme new.
	space root addChild: w.
	w layout: BlBasicLayout new.
	skin := ToBeeSkin new.
	layoutDirectionProp := self writablePropertyIndex propertyNamed:
		                       #'layout-direction'.
	layoutProp := self writablePropertyIndex propertyNamed: #layout.
	directionWriter := ToPropertyWriter new
		                   eventClass: ToInstallSkinEvent;
		                   property: layoutDirectionProp;
		                   value: BlLayoutDirection rightToLeft;
		                   yourself.
	layoutWriter := ToPropertyWriter new
		                eventClass: ToInstallSkinEvent;
		                property: layoutProp;
		                value: BlLinearLayout new;
		                yourself.
	skin skinEventListeners: {
			directionWriter.
			layoutWriter }.

	" Since checkSkinInstallation will switch to ToInstallState "
	" the installation will fail because the widget layout (not a BlLinearLayout) does not understand #direction:"
	w defaultSkin: skin.
	w ensuredSkinManager requestInstallSkinIn: w.
	" since applySkinInstaller will applyStyles "
	self
		should: [ w skinManager applySkinReinstallIn: w ]
		raise: MessageNotUnderstood.

	" Now change writers order and it should be ok "
	skin skinEventListeners: {
			layoutWriter.
			directionWriter }.

	w skinManager skinStateQueue enqueueInstallStateForElement: w.
	w skinManagerDo: [ :sm | sm applyEnqueuedStatesIn: w ].
	self assert: (w layout isKindOf: BlLinearLayout).
	self assert: w layout direction isRightToLeft
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testSkinEventAction [

	| w skin action |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	action := ToSkinEventAction new action: [ :e |
		          e background: Color blue ].
	skin skinEventListeners: { action }.
	self assert: skin skinEventListeners size equals: 1.
	self assert: skin skinEventListeners first identicalTo: action.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.

	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testSkinEventActionMixedWithWriter [

	| w skin action prop propWriter |
	w := ToElement new.
	space root addChild: w.
	action := ToSkinEventAction new action: [ :e |
		          e background: Color red ].
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin := ToStyleSheetSkin new.
	" SkinEventAction instances must be before all PropertyWriter instances. 
	This must be ensured by the skin building procedure"
	skin skinEventListeners: {
			action.
			propWriter }.
	self assert: skin skinEventListeners size equals: 2.
	self assert: skin skinEventListeners first identicalTo: action.
	self assert: skin skinEventListeners second identicalTo: propWriter.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.
	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testSkinEventListeners [

	| w skin prop propWriter |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	prop := self writablePropertyIndex propertyNamed: #background.
	propWriter := ToPropertyWriter new
		              property: prop;
		              value: Color blue;
		              yourself.
	skin skinEventListeners: { propWriter }.
	self assert: skin skinEventListeners size equals: 1.
	self assert: skin skinEventListeners first identicalTo: propWriter.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.

	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testSupplementWriter [

	| w skin backgroundProp borderProp borderBuilder |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	borderBuilder := BlBorderBuilder new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin skinEventListeners: {
			(ToPropertyWriter new
				 eventClass: ToInstallSkinEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: [ :e | Color yellow ];
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInstallSkinEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color red;
						 build ] yourself).
			(ToPropertyWriter new
				 supplement: true;
				 eventClass: ToInstallSkinEvent;
				 property: borderProp;
				 value: [ :e |
					 borderBuilder
						 paint: Color black;
						 dashArray: #( 4 5 );
						 build ] yourself) }.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color black.
	self assert: w border style dashArray equals: #( 4 5 )
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testWithAnimationOn2EventClasses [

	| w skin prop animation |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	animation := ToPropertyColorTransitionAnimation new.
	prop := self writablePropertyIndex propertyNamed: #'background'.

	skin skinEventListeners: {
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToInstallSkinEvent;
				 value: Color white;
				 yourself).
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToHoveredSkinEvent;
				 value: Color black;
				 animation: animation;
				 yourself).
			(ToPropertyWriter new
				 property: prop;
				 eventClass: ToLeftSkinEvent;
				 value: Color white;
				 animation: animation;
				 yourself) }.

	w defaultSkin: skin.
	w ensuredSkinManager requestInstallSkinIn: w.
	w skinManager applySkinReinstallIn: w.

	self assert: w background paint color equals: Color white.

	w skinManager
		enqueueSkinState:
		(ToTransientState skinEvent: ToHoveredSkinEvent new)
		in: w.
	animation onFinishedDo: [ :x |
		self assert: w background paint color equals: Color black.

		w skinManager
			enqueueSkinState:
			(ToTransientState skinEvent: ToLeftSkinEvent new)
			in: w.
		animation onFinishedDo: [ :xx |
			self assert: w background paint color equals: Color white ] ]
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testWithNoWriter [

	| w skin paint |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	w defaultSkin: skin.
	paint := w background paint.
	w skinManager applySkinReinstallIn: w.

	self assert: w background paint equals: paint
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWriters [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin skinEventListeners: {
			(ToPropertyWriter new
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: Color yellow;
				 yourself) }.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.

	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : #'test with accessors' }
ToStyleSheetSkinTest >> testWithTwoWritersTwoEventClasses [

	| w skin backgroundProp borderProp |
	w := ToElement new.
	space root addChild: w.
	skin := ToStyleSheetSkin new.
	backgroundProp := self writablePropertyIndex propertyNamed:
		                  #background.
	borderProp := self writablePropertyIndex propertyNamed: #border.
	skin skinEventListeners: {
			(ToPropertyWriter new
				 eventClass: ToInstallSkinEvent;
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInstallSkinEvent;
				 property: borderProp;
				 value: Color yellow;
				 yourself).
			(ToPropertyWriter new
				 eventClass: ToInstallSkinEvent;
				 property: borderProp;
				 value: Color red;
				 yourself) }.
	w defaultSkin: skin.
	w skinManager applySkinReinstallIn: w.

	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color red
]

{ #category : #running }
ToStyleSheetSkinTest >> writablePropertyIndex [

	^ writeablePropertyIndex
]
