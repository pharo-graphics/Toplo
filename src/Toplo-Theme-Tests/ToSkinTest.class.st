"
A ToSkinTest is a test class for testing the behavior of ToSkin
"
Class {
	#name : #ToSkinTest,
	#superclass : #TestCase,
	#instVars : [
		'propertyIndex'
	],
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #running }
ToSkinTest >> propertyIndex [

	^ propertyIndex
]

{ #category : #running }
ToSkinTest >> propertyList [

	^ ToStyleSheet propertyList
]

{ #category : #running }
ToSkinTest >> setUp [ 

	super setUp.
	propertyIndex := ToPropertyIndex new recordAll: self propertyList; yourself
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithNoSubscription [

	| w skin paint |
	w := ToElement new.
	skin := ToSkin new.
	w withSkin: skin.
	paint := w background paint.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint equals: paint
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithOneSubscriptionWithOneWriter [

	| w skin prop propWriter eventSubscription |
	w := ToElement new.
	skin := ToSkin new.
	prop := self propertyIndex propertyNamed: #background.
	propWriter := prop newWriterForValue: Color blue.
	eventSubscription := ToLookEventSubscription new.
	eventSubscription eventClass: ToInstallLookEvent.
	eventSubscription writers: { propWriter }.
	skin addSubscription: eventSubscription.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color blue
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithOneSubscriptionWithTwoWriters [

	| w skin eventSubscription backgroundProp borderProp |
	w := ToElement new.
	skin := ToSkin new.
	backgroundProp := self propertyIndex propertyNamed: #background.
	borderProp := self propertyIndex propertyNamed: #border.
	eventSubscription := ToLookEventSubscription new.
	eventSubscription eventClass: ToInstallLookEvent.
	eventSubscription writers: {
			(ToPropertyWriter new
				 property: backgroundProp;
				 value: Color blue;
				 yourself).
			(ToPropertyWriter new
				 property: borderProp;
				 value: Color yellow;
				 yourself) }.
	skin addSubscription: eventSubscription.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color blue.
	self assert: w border paint color equals: Color yellow
]

{ #category : #'test with accessors' }
ToSkinTest >> testWithTwoSubscriptions [

	| w skin backgroundProp eventSubscription1 eventSubscription2 |
	w := ToElement new.
	skin := ToSkin new.
	backgroundProp := self propertyIndex propertyNamed: #background.
	eventSubscription1 := ToLookEventSubscription new.
	eventSubscription1 eventClass: ToInstallLookEvent.
	eventSubscription1 writers: { (ToPropertyWriter new
			 property: backgroundProp;
			 value: Color blue;
			 yourself) }.
	eventSubscription2 := ToLookEventSubscription new.
	eventSubscription2 eventClass: ToHoveredLookEvent.
	eventSubscription2 writers: { (ToPropertyWriter new
			 property: backgroundProp;
			 value: Color red;
			 yourself) }.
	skin subscriptions: {
			eventSubscription1.
			eventSubscription2 }.
	w withSkin: skin.
	w switchToSkinState: ToInstallState new.
	self assert: w background paint color equals: Color blue.
	w switchToSkinState: ToHoveredState new.
	self assert: w background paint color equals: Color red
]
