Class {
	#name : #ToNumericalBadge,
	#superclass : #ToBadge,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#counter => ObservableSlot'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToNumericalBadge >> counter [

	^ counter
]

{ #category : #accessing }
ToNumericalBadge >> counter: aNumber [

	counter := aNumber
]

{ #category : #'private - accessing' }
ToNumericalBadge >> counterChanged [

	label text: counter asString.
]

{ #category : #accessing }
ToNumericalBadge >> decrement [

	self decrementBy: 1
]

{ #category : #accessing }
ToNumericalBadge >> decrementBy: aNumber [

	counter := counter - aNumber
]

{ #category : #accessing }
ToNumericalBadge >> increment [

	self incrementBy: 1
]

{ #category : #accessing }
ToNumericalBadge >> incrementBy: aNumber [

	counter := counter + aNumber
]

{ #category : #initialization }
ToNumericalBadge >> initialize [

	super initialize.
	self class initializeSlots: self.
	self property: #counter whenChangedDo: [ self counterChanged ].
	self counter: 0
]
