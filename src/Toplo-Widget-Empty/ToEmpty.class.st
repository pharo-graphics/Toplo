Class {
	#name : #ToEmpty,
	#superclass : #ToElement,
	#instVars : [
		'image'
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

{ #category : #initialization }
ToEmpty >> initialize [ 

	super initialize.
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

{ #category : #skin }
ToEmpty >> newRawSkin [ 

	^ ToEmptySkin new
]
