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
	self fitContent
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
ToEmpty >> labelText: aStringOrText [

	label ifNotNil: [ label removeFromParent ].
	aStringOrText ifNil: [
		label := nil.
		^ self ].
	label := ToSelectableLabel new text: aStringOrText.
	label addStamp: #placeholder.
	label constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear vertical alignCenter ].
	self addChild: label 
]

{ #category : #skin }
ToEmpty >> newRawSkin [ 

	^ ToEmptySkin new
]
