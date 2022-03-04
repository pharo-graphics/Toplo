Class {
	#name : #ToLookChanges,
	#superclass : #Object,
	#instVars : [
		'initialized',
		'changes'
	],
	#category : #'Toplo-Core-Changes'
}

{ #category : #adding }
ToLookChanges >> add: aChange [
	aChange source: thisContext sender method.
	changes add: aChange
]

{ #category : #accessing }
ToLookChanges >> changes [
	^ changes
]

{ #category : #initialization }
ToLookChanges >> downOn: aLook [
	self assert: [ initialized ].
	changes reversed do: [ :e | e downOn: aLook ].
	initialized := false
]

{ #category : #initialization }
ToLookChanges >> initialize [
	super initialize.
	initialized := false.
	changes := OrderedCollection new
]

{ #category : #initialization }
ToLookChanges >> upOn: aLook [
	self assert: [ initialized not ].
	changes do: [ :e | e upOn: aLook ].
	initialized := true
]
