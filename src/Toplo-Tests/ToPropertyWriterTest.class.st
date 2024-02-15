"
A ToPropertyWriterTest is a test class for testing the behavior of ToPropertyWriter
"
Class {
	#name : #ToPropertyWriterTest,
	#superclass : #ToParameterizedHostTest,
	#category : 'Toplo-Tests-Core-StyleSheet'
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

	| w prop propWriter anim wasHere |
	w := BlElement new.
	w background: Color red.
	space root addChild: w.
	prop := ToPseudoProperty new.
	prop name: #background.
	prop writer: [ :e :v | e background: v ].
	prop reader: nil.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation:
		(anim := ToPropertyColorTransitionAnimation new
			         property: prop;
			         duration: 1 milliSeconds).
	self should: [ propWriter writeTo: w ] raise: MessageNotUnderstood.

	"now setup a reader and it should be ok "
	prop reader: [ :e | e background paint color ].
	propWriter animation:
		(anim := ToPropertyColorTransitionAnimation new property: prop).
	wasHere := false.
	anim onFinishedDo: [ :e |
		wasHere := true.
		self assert: (e background isKindOf: BlPaintBackground).
		self assert: e background paint color equals: Color blue.
		self assert: (prop read: e) equals: e background paint color ].

	propWriter writeTo: w.
	self waitTestingSpaces.
	self assert: wasHere
]

{ #category : #tests }
ToPropertyWriterTest >> testCanReceiveEvent [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredLookEvent.
	self assert: (propWriter canReceiveEvent: ToHoveredLookEvent new).
	self deny: (propWriter canReceiveEvent: ToLeavedLookEvent new)
]

{ #category : #tests }
ToPropertyWriterTest >> testEventClass [

	| propWriter |
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredLookEvent.
	self assert: propWriter eventClass identicalTo: ToHoveredLookEvent
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
	propWriter receiveEvent: (ToInstallLookEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]

{ #category : #tests }
ToPropertyWriterTest >> testReceiveEvent [

	| w propWriter evt |
	w := BlElement new.
	w background: Color red.
	evt := ToHoveredLookEvent new currentTarget: w.
	propWriter := ToPropertyWriter new.
	propWriter eventClass: ToHoveredLookEvent.
	propWriter property: (ToFeatureProperty new name: #background).
	propWriter value: (BlBackground paint: Color blue).
	self assert: w background paint color equals: Color red.
	propWriter receiveEvent: evt.
	self assert: w background paint color equals: Color blue.
	evt := ToLeavedLookEvent new currentTarget: w.
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
	propWriter eventClass: ToHoveredLookEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	space root addChild: target.
	wasHere := false.
	anim onFinishedDo: [ :w |
		wasHere := true.
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background ].
	propWriter receiveEvent: (ToHoveredLookEvent new currentTarget: target).
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
	propWriter eventClass: ToHoveredLookEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	space root addChild: target.
	wasHere := false.
	anim onFinishedDo: [ :w |
		wasHere := true.
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background. ].
	propWriter receiveEvent: (ToHoveredLookEvent new currentTarget: target).
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
	propWriter eventClass: ToInstallLookEvent.
	propWriter receiveEvent: (ToInstallLookEvent new currentTarget: target).
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
	propWriter eventClass: ToInstallLookEvent.
	propWriter receiveEvent: (ToInstallLookEvent new currentTarget: target).
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
	propWriter eventClass: ToInstallLookEvent.
	propWriter value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w.
	self should: [ propWriter receiveEvent: installEvent ] raise: MessageNotUnderstood
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testWriterNeedProperty [

	| w writer event |

	w := ToElement new.
	writer := ToPropertyWriter new property: nil.
	writer eventClass: ToInstallLookEvent.
	writer value: [ :e | e background: Color white ].
	event := ToInstallLookEvent new currentTarget: w.
	self should: [ writer receiveEvent: event ] raise: MessageNotUnderstood 
]
