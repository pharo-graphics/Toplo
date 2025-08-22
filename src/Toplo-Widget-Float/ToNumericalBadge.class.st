Class {
	#name : #ToNumericalBadge,
	#superclass : #ToLabelledBadge,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#count => ObservableSlot',
		'#overflowCount => ObservableSlot'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #accessing }
ToNumericalBadge >> count [

	^ count ifNil: [ count := 0 ]
]

{ #category : #accessing }
ToNumericalBadge >> count: aNumber [

	count := aNumber
]

{ #category : #'private - accessing' }
ToNumericalBadge >> countChanged [

	| n t |
	n := self count min: self overflowCount.
	t := String streamContents: [ :str |
			     str nextPutAll: n asString.
			     count > overflowCount ifTrue: [ str nextPut: $+ ] ].
	label text: t
]

{ #category : #accessing }
ToNumericalBadge >> decrement [

	self decrementBy: 1
]

{ #category : #accessing }
ToNumericalBadge >> decrementBy: aNumber [

	count := self count - aNumber
]

{ #category : #accessing }
ToNumericalBadge >> increment [

	self incrementBy: 1
]

{ #category : #accessing }
ToNumericalBadge >> incrementBy: aNumber [

	count := self count + aNumber
]

{ #category : #initialization }
ToNumericalBadge >> initialize [

	super initialize.
	self class initializeSlots: self.
	self property: #count whenChangedDo: [ self countChanged ].
	self property: #overflowCount whenChangedDo: [ self countChanged ].
	self tooltipBuilder: [ :window :request |
			window root addChild: ((ToLabel text: self count asString)
					 defaultRawSkin: ToLabelInTooltipSkin new;
					 yourself) ].
	self countChanged
]

{ #category : #accessing }
ToNumericalBadge >> overflowCount [

	^ overflowCount ifNil: [ overflowCount := 99 ]
]

{ #category : #accessing }
ToNumericalBadge >> overflowCount: aNumber [

	overflowCount := aNumber
]
