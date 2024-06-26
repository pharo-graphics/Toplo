Class {
	#name : #ToPropertyWriter,
	#superclass : #ToSkinEventListener,
	#instVars : [
		'property',
		'value',
		'animation',
		'supplement'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #visiting }
ToPropertyWriter >> accept: aVisitor [

	self isSupplement
		ifTrue: [ aVisitor visitPropertyWriterForSupplement: self ]
		ifFalse: [ aVisitor visitPropertyWriter: self ]
]

{ #category : #accessing }
ToPropertyWriter >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertyWriter >> animation: aPropertyAnimation [

	animation := aPropertyAnimation
]

{ #category : #'look event handling' }
ToPropertyWriter >> applyOn: anObject [

	self writeTo: anObject
]

{ #category : #testing }
ToPropertyWriter >> isPropertyWriter [

	^ true
]

{ #category : #testing }
ToPropertyWriter >> isSupplement [

	^ self supplement 
]

{ #category : #printing }
ToPropertyWriter >> printOn: aStream [

	super printOn: aStream.
	self supplement 
		ifTrue: [ aStream nextPutAll: ' supplement: '] 
		ifFalse: [ aStream nextPutAll: ' write: ' ].
	aStream space.
	self property ifNotNil: [ aStream nextPutAll: self property name ].
	aStream space.
	aStream nextPutAll: 'when: '.
	aStream nextPutAll: self eventClass asString.
	aStream space.
	aStream nextPutAll: 'with: '.
	self value printOn: aStream
]

{ #category : #accessing }
ToPropertyWriter >> property [

	^ property
]

{ #category : #accessing }
ToPropertyWriter >> property: anObject [

	property := anObject
]

{ #category : #accessing }
ToPropertyWriter >> supplement [ 

	^ supplement ifNil: [ supplement := false ]
]

{ #category : #accessing }
ToPropertyWriter >> supplement: aBoolean [

	supplement := aBoolean
]

{ #category : #accessing }
ToPropertyWriter >> value [

	^ value
]

{ #category : #accessing }
ToPropertyWriter >> value: aBlockOrObject [

	value := aBlockOrObject
]

{ #category : #operating }
ToPropertyWriter >> valueFrom: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]

{ #category : #operating }
ToPropertyWriter >> writeTo: anElement [

	self animation ifNil: [ ^ self property write: (self valueFrom: anElement) to: anElement ].
	self animation property: self property.
	self animation write: (self valueFrom: anElement) to: anElement
]
