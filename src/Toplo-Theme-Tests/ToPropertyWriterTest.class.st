"
A ToPropertyWriterTest is a test class for testing the behavior of ToPropertyWriter
"
Class {
	#name : #ToPropertyWriterTest,
	#superclass : #TestCase,
	#category : 'Toplo-Theme-Tests-Skin'
}

{ #category : #'test writing' }
ToPropertyWriterTest >> testAnimationNeedPropertyWithReader [

	| w prop propWriter anim |
	w := BlElement new.
	prop := ToPseudoProperty new.
	prop name: #background.
	prop writer: [ :e :v | e background: v ].
	prop reader: nil.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToPropertyColorTransitionAnimation new property: prop).
	self should: [propWriter writeTo: w ] raise: MessageNotUnderstood.
	
	"now setup a reader and it should be ok "
	prop reader: [ :e | e background ].
	anim onFinishedDo: [
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testCheckableUpdateWithValuable [

	| w disabledImage checkedImage uncheckedImage indeterminateImage switch prop writer |
	w := ToCheckLookTestElement new.

	disabledImage := BlElement new.
	checkedImage := BlElement new.
	uncheckedImage := BlElement new.
	indeterminateImage := BlElement new.
	
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
	prop := ToPseudoProperty
		        name: #'checkable-icon-image'
		        reader: [ :e | e icon innerImage ]
		        writer: [ :e :v |
			        v removeFromParent.
			        e iconImage: v ].
	writer := ToPropertyWriter new
		          property: prop;
		          value: switch;
		          eventClass: ToInitialLookEvent;
		          yourself.

	writer receiveEvent: (ToInitialLookEvent new currentTarget: w).
	" since the checkable is unchecked by default "
	self assert: w icon innerImage equals: uncheckedImage.

	w checked: true.
	writer receiveEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: checkedImage.

	w checked: nil.
	writer receiveEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: indeterminateImage.

	w disable.
	writer receiveEvent: (ToInitialLookEvent new currentTarget: w).
	self assert: w icon innerImage equals: disabledImage
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

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithAnimationWithRawValue [

	| prop propWriter target anim |
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter eventClass: ToHoveredLookEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	anim onFinishedDo: [
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background ].
	propWriter receiveEvent: (ToHoveredLookEvent new currentTarget: target).
	" have to wait animation termination "
	self assert: target background paint isNil
]

{ #category : #'test event receiving' }
ToPropertyWriterTest >> testReceiveEventWithFeaturePropertyWithAnimationWithValuable [

	| prop propWriter target target2 anim |
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [ :e | target2 := e. Color blue].
	propWriter eventClass: ToHoveredLookEvent.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	target := BlElement new.
	anim onFinishedDo: [
		self assert: (target background isKindOf: BlPaintBackground).
		self assert: target background paint color equals: Color blue.
		self assert: (prop read: target) equals: target background. ].
	propWriter receiveEvent: (ToHoveredLookEvent new currentTarget: target).
	" the valuable value is interpreted ** before ** animation running "
	self assert: target2 identicalTo: target.
	" have to wait animation termination "
	self assert: target background paint isNil
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
	propWriter eventClass: ToInitialLookEvent.
	propWriter receiveEvent: (ToInitialLookEvent new currentTarget: target).
	self assert: target2 identicalTo: target.
	self assert: (target background isKindOf: BlPaintBackground).
	self assert: target background paint color equals: Color blue.
	self assert: (prop read: target) equals: target background

]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithFeaturePropertyAndAnimation [

	| w prop propWriter anim |
	w := BlElement new.
	prop := ToFeatureProperty new.
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
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

	| w prop propWriter anim |
	w := BlElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: Color blue.
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithPseudoPropertyWithConverterMethod [

	| w prop  |
	w := BlElement new.
	prop := ToPseudoProperty new.
	prop writer:  [ :e :v | e background: v ].
	prop reader:  [ :e | e background ].
	prop name: #background.
	(prop value: Color blue) writeTo: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #'test writing' }
ToPropertyWriterTest >> testWithPseudoPropertyWithValuableAndAnimation [

	| w prop propWriter anim w2 |
	w := BlElement new.
	prop := ToPseudoProperty new.
	prop writer: [ :e :v | e background: v ].
	prop reader: [ :e | e background ].
	prop name: #background.
	propWriter := ToPropertyWriter new.
	propWriter property: prop.
	propWriter value: [:e | w2 := e. Color blue].
	propWriter animation: (anim := ToBackgroundColorAnimationForTest new property: prop).
	anim onFinishedDo: [
		self assert: w2 identicalTo: w.
		self assert: (w background isKindOf: BlPaintBackground).
		self assert: w background paint color equals: Color blue.
		self assert: (prop read: w) equals: w background ].
	propWriter writeTo: w
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
