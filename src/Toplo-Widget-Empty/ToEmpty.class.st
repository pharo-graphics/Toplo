Class {
	#name : #ToEmpty,
	#superclass : #ToElement,
	#instVars : [
		'image',
		'label'
	],
	#category : #'Toplo-Widget-Empty'
}

{ #category : #'instance creation' }
ToEmpty class >> box [

	^ self new
		  addStamp: #box;
		  yourself
]

{ #category : #initialization }
ToEmpty class >> initializeToRawTheme: aTheme [

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme addTokenNamed: #'empty-image-size' withValue: 50.
	aTheme addTokenNamed: #'empty-sector-height' withValue: 4.
]

{ #category : #'instance creation' }
ToEmpty class >> waiting [

	^ self new
		  addStamp: #waiting;
		  yourself
]

{ #category : #accessing }
ToEmpty >> builder: aValuable [

	aValuable value: self
]

{ #category : #initialization }
ToEmpty >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #accessing }
ToEmpty >> image [ 

	^ image
]

{ #category : #initialization }
ToEmpty >> initialize [ 

	super initialize.
	self labelText: 'No data'.
	self matchParent
]

{ #category : #initialization }
ToEmpty >> installInnerImage: anInnerImage [

	image ifNotNil: [ image removeFromParent ].
	anInnerImage ifNil: [
		image := nil.
		^ self ].
	image := ToImage inner: anInnerImage.
	image constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear vertical alignCenter ].
	self addChild: image at: 1
]

{ #category : #initialization }
ToEmpty >> label: aLabel [

	label ifNotNil: [
		label removeFromParent.
		label := nil ].
	aLabel ifNil: [ ^ self ].
	label := aLabel.
	label addStamp: #placeholder.
	label constraintsDo: [ :c |
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].
	label hFitContent.
	self addChild: label
]

{ #category : #initialization }
ToEmpty >> labelText: aStringOrText [

	aStringOrText ifNil: [
		self label: nil.
		^ self ].
	self label: (ToSelectableLabel new
			 text: aStringOrText;
			 yourself)
]

{ #category : #skin }
ToEmpty >> newRawSkin [ 

	^ ToEmptySkin new
]
