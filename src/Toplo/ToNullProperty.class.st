Class {
	#name : #ToNullProperty,
	#superclass : #ToAbstractProperty,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToNullProperty class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
ToNullProperty >> initialize [ 

	super initialize.
	name := 'NullProperty'
]

{ #category : #operating }
ToNullProperty >> read: anObject [

	self shouldNotImplement 
]
