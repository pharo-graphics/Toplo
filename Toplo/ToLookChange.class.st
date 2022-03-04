Class {
	#name : #ToLookChange,
	#superclass : #Object,
	#instVars : [
		'initialized',
		'up',
		'down',
		'source'
	],
	#category : #'Toplo-Core-Changes'
}

{ #category : #accessing }
ToLookChange >> down [
	^ down
]

{ #category : #accessing }
ToLookChange >> down: aUnaryBlockClosure [
	down := aUnaryBlockClosure
]

{ #category : #initialization }
ToLookChange >> downOn: aLook [
	self assert: [ initialized ].
	down value: aLook.
	initialized := false
]

{ #category : #initialization }
ToLookChange >> initialize [
	super initialize.
	initialized := false.
	up := [ :e |  ].
	down := [ :e |  ]
]

{ #category : #accessing }
ToLookChange >> initialized [
	^ initialized
]

{ #category : #accessing }
ToLookChange >> initialized: aBoolean [
	initialized := aBoolean
]

{ #category : #accessing }
ToLookChange >> source [
	^ source
]

{ #category : #accessing }
ToLookChange >> source: anObject [
	source := anObject
]

{ #category : #accessing }
ToLookChange >> up [
	^ up
]

{ #category : #accessing }
ToLookChange >> up: aUnaryBlockClosure [
	up := aUnaryBlockClosure
]

{ #category : #initialization }
ToLookChange >> upOn: aLook [
	self assert: [ initialized not ].
	up value: aLook.
	initialized := true
]
