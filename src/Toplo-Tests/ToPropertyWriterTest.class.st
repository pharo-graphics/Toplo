"
A ToPropertyWriterTest is a test class for testing the behavior of ToPropertyWriter
"
Class {
	#name : #ToPropertyWriterTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToPropertyWriterTest >> testAnimation [

	| propWriter |
	propWriter := ToPropertyWriter new.
	self assert: propWriter animation isNil.
	propWriter animation: ToPropertyBorderColorTransitionAnimation new.
	self assert: propWriter animation notNil
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testAnimationNeedPropertyWithReader [

	| w prop propWriter anim onFinishedDone |
	w := BlElement new.
	w size: 100 asPoint.
	w background: Color red.
	space root addChild: w.
	prop := ToPseudoProperty new.
	prop name: #background.
	prop writer: [ :e :v | e background: v ].
	prop reader: nil.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	anim := ToPropertyColorTransitionAnimation new
		        property: prop;
		        duration: 200 milliSeconds;
		        yourself.
	propWriter animation: anim.
	self should: [ propWriter writeTo: w ] raise: MessageNotUnderstood.

	"now setup a reader and it should be ok "
	prop reader: [ :e | e background paint color ].
	anim := ToPropertyColorTransitionAnimation new
		        property: prop;
		        duration: 200 milliSeconds;
		        yourself.
	onFinishedDone := false.
	anim onFinishedDo: [ :e |
			onFinishedDone := true.
			self assert: (e background isKindOf: BlPaintBackground).
			self assert: e background paint color equals: Color blue.
			self assert: (prop read: e) equals: e background paint color ].
	propWriter animation: anim.
	propWriter writeTo: w.

	self waitTestingSpacesTimeout: 300 milliSeconds.
	self assert: onFinishedDone
]

{ #category : #tests }
ToPropertyWriterTest >> testCanReceiveEvent [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredSkinEvent.
	self assert: (propWriter canReceiveEvent: ToHoveredSkinEvent new).
	self deny: (propWriter canReceiveEvent: ToLeftSkinEvent new)
]

{ #category : #tests }
ToPropertyWriterTest >> testEventClass [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredSkinEvent.
	self assert: propWriter eventClass identicalTo: ToHoveredSkinEvent
]

{ #category : #tests }
ToPropertyWriterTest >> testIsSupplement [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter supplement: true.
	self assert: propWriter isSupplement
]

{ #category : #tests }
ToPropertyWriterTest >> testProperty [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter property: (ToFeatureProperty new name: #background).
	self assert: propWriter property name equals: #background

]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveDefaultEventWithFeaturePropertyWithRawValue [

	| w prop  propWriter target |
	w := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	target := BlElement new.
	propWriter receiveEvent: (ToInstallSkinEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]

{ #category : #tests }
ToPropertyWriterTest >> testReceiveEvent [

	| w propWriter evt |
	w := BlElement new.
	w background: Color red.
	evt := ToHoveredSkinEvent new currentTarget: w.
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredSkinEvent.
	propWriter property: (ToFeatureProperty new name: #background).
	propWriter value: (BlBackground paint: Color blue).
	self assert: w background paint color equals: Color red.
	propWriter receiveEvent: evt.
	self assert: w background paint color equals: Color blue.
	evt := ToLeftSkinEvent new currentTarget: w.
	propWriter receiveEvent: evt.
	self assert: w background paint color equals: Color blue



	

]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithAnimationWithRawValue [

	| prop propWriter target anim wasHere |
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter eventClass: ToHoveredSkinEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	space root addChild: target.
	wasHere := false.
	anim onFinishedDo: [ :w |
		wasHere := true.
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background ].
	propWriter receiveEvent: (ToHoveredSkinEvent new currentTarget: target).
	" have to wait animation termination ".
	self waitTestingSpaces.
	self assert: wasHere.
	self assert: target background paint color equals: Color blue
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithAnimationWithValuable [

	| prop propWriter target target2 anim wasHere |
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [ :e | target2 := e. Color blue].
	propWriter eventClass: ToHoveredSkinEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	space root addChild: target.
	wasHere := false.
	anim onFinishedDo: [ :w |
		wasHere := true.
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background. ].
	propWriter receiveEvent: (ToHoveredSkinEvent new currentTarget: target).
	" the valuable value is interpreted ** before ** animation running "
	self assert: target2 identicalTo: target.
	" have to wait animation termination "
	self assert: target background paint isNil.
	self waitTestingSpaces.
	self assert: wasHere.
	self assert: target background paint color equals: Color blue
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithRawValue [

	| w prop  propWriter target |
	w := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	target := BlElement new.
	propWriter eventClass: ToInstallSkinEvent.
	propWriter receiveEvent: (ToInstallSkinEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithValuable [

	| prop  propWriter target target2|
	target := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | target2 := e. Color blue].
	propWriter eventClass: ToInstallSkinEvent.
	propWriter receiveEvent: (ToInstallSkinEvent new currentTarget: target).
	self assert: target2 identicalTo: target.
	self assert: (target background isKindOf: BlPaintBackground).
	self assert: target background paint color equals: Color blue.
	self assert: (prop read: target) equals: target background

]

{ #category : #tests }
ToPropertyWriterTest >> testSupplement [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter supplement: true.
	self assert: (propWriter supplement).

]

{ #category : #tests }
ToPropertyWriterTest >> testValue [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter value: Color blue.
	self assert: propWriter value equals: Color blue
]

{ #category : #tests }
ToPropertyWriterTest >> testValueFrom [

	| w propWriter |
	propWriter := ToPropertyWriter new.
	propWriter value: Color blue.
	self assert: propWriter value equals: Color blue.
	w := BlElement new.
	w background: Color red.
	self assert: (propWriter valueFrom: w) equals: Color blue.
	propWriter value: [:e | e background paint color ].
	self assert: (propWriter valueFrom: w) equals: Color red
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithFeaturePropertyAndAnimation [

	| w prop propWriter anim wasHere |
	w := BlElement new.
	space root addChild: w.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	wasHere := false.
	anim onFinishedDo: [:args |
		wasHere := true.
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w.
	self waitTestingSpaces.
	self assert: wasHere
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithFeaturePropertyWithRawValue [

	| w prop  propWriter |
	w := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter writeTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithFeaturePropertyWithValuable [

	| w prop  propWriter w2 |
	w := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | w2 := e. Color blue].
	propWriter writeTo: w.
	self assert: w2 identicalTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithPseudoProperty [

	| w prop  propWriter |
	w := BlElement new.
	prop := ToPseudoProperty new.
	prop writer:  [ :e :v | e background: v ].
	prop reader:  [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter writeTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithPseudoPropertyAndAnimation [

	| w prop propWriter anim wasHere |
	w := BlElement new.
	space root addChild: w.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	wasHere := false.
	anim onFinishedDo: [:args |
		wasHere := true.
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w.
	self waitTestingSpaces.
	self assert: wasHere
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithPseudoPropertyWithValuableAndAnimation [

	| w prop propWriter anim w2 wasHere |
	w := BlElement new.
	space root addChild: w.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | w2 := e. Color blue].
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	wasHere := false.
	anim onFinishedDo: [:args |
		wasHere := true.
		self assert: w2 identicalTo: w.
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w.
	self waitTestingSpaces.
	self assert: wasHere
]

{ #category : #tests }
ToPropertyWriterTest >> testWriteTo [

	| w propWriter color |
	w := BlElement new.
	color := Color yellow.
	w background: Color red.
	propWriter := ToPropertyWriter new.
	propWriter property: (ToFeatureProperty new name: #background).
	propWriter value: (BlBackground paint: Color blue).
	propWriter writeTo: w.
	self assert: w background paint color equals: Color blue.
	propWriter value: [:e | color].
	propWriter writeTo: w.
	self assert: w background paint color equals: Color yellow



	

]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testWriterFailsWithPseudoPropertyWithWrongWriter [

	| w  installEvent prop propWriter |
	w := ToElement new.
	prop := ToPseudoProperty new name: #'font-name'.
	prop writer: [ :e :v | e fontName: v ].

	propWriter := ToPropertyWriter new property: prop.
	propWriter eventClass: ToInstallSkinEvent.
	propWriter value: Color white.

	installEvent := ToInstallSkinEvent new currentTarget: w.
	self should: [ propWriter receiveEvent: installEvent ] raise: MessageNotUnderstood
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testWriterNeedProperty [

	| w writer event |

	w := ToElement new.
	writer := ToPropertyWriter new property: nil.
	writer eventClass: ToInstallSkinEvent.
	writer value: [ :e | e background: Color white ].
	event := ToInstallSkinEvent new currentTarget: w.
	self should: [ writer receiveEvent: event ] raise: MessageNotUnderstood 
]
