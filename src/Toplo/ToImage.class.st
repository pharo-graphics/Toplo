Class {
	#name : #ToImage,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Images'
}

{ #category : #initialization }
ToImage >> defaultViewModel [

	^ ToImageViewModel new.

]

{ #category : #accessing }
ToImage >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToImage >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #accessing }
ToImage >> image [

	^ self viewModel image
]

{ #category : #accessing }
ToImage >> image: anImageElement [

	self viewModel image: anImageElement
]

{ #category : #initialization }
ToImage >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	self fitContent
]

{ #category : #private }
ToImage >> privateImage [

	^ innerElement
]

{ #category : #private }
ToImage >> privateImage: anImageElement [

	innerElement = anImageElement ifTrue: [ ^ self ].
	self removeChildren.
	innerElement := anImageElement.
	anImageElement ifNotNil: [ self addChild: innerElement].
	self invalidate
]

{ #category : #accessing }
ToImage >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToImage >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
