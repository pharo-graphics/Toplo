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
	prop := self propertyIndex propertyNamed: #background.
	propWriter := prop newWriterForValue: Color blue.
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
	backgroundProp := self propertyIndex propertyNamed: #background.
	borderProp := self propertyIndex propertyNamed: #border.
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
	backgroundProp := self propertyIndex propertyNamed: #background.
	borderProp := self propertyIndex propertyNamed: #border.
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
