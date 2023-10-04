Class {
	#name : #ToPlaceholderLayer,
	#superclass : #ToElementLayer,
	#category : #'Toplo-Core'
}

{ #category : #converting }
ToPlaceholderLayer >> asPlaceholderLayer [

	^ self
]

{ #category : #initialization }
ToPlaceholderLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self preventMouseEvents.

]
