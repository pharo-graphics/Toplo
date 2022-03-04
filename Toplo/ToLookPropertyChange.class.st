Class {
	#name : #ToLookPropertyChange,
	#superclass : #ToLookChange,
	#instVars : [
		'old',
		'new',
		'read',
		'path',
		'value'
	],
	#category : #'Toplo-Core-Changes'
}

{ #category : #initialization }
ToLookPropertyChange >> downOn: aLook [
	self assert: [ initialized ].
	down value: aLook value: old value: new.
	old := nil.
	new := nil.
	initialized := false
]

{ #category : #initialization }
ToLookPropertyChange >> initialize [
	super initialize.
	read := [ :e | self readOn: e ].
	up := [ :e :f | 
	self
		writeOn: e
		value:
			(value isBlock
				ifTrue: [ value cull: f ]
				ifFalse: [ value ]) ].
	down := [ :e :f :g | self writeOn: e value: f ]
]

{ #category : #accessing }
ToLookPropertyChange >> path [
	^ path
]

{ #category : #accessing }
ToLookPropertyChange >> path: anObject [
	path := anObject
]

{ #category : #printing }
ToLookPropertyChange >> printOn: aStream [
	aStream nextPutAll: (' ' join: (path collect: #asString))
]

{ #category : #initialization }
ToLookPropertyChange >> readOn: aLook [

	^ path inject: aLook into: [ :e :f | e perform: f ]
]

{ #category : #initialization }
ToLookPropertyChange >> upOn: aLook [
	self assert: [ initialized not ].
	old := read value: aLook.
	up value: aLook value: old.
	new := read value: aLook.
	initialized := true
]

{ #category : #accessing }
ToLookPropertyChange >> value [
	^ value
]

{ #category : #accessing }
ToLookPropertyChange >> value: anObject [
	value := anObject
]

{ #category : #initialization }
ToLookPropertyChange >> writeOn: aLook value: anObject [
	| receiver |
	receiver := (path copyFrom: 1 to: path size - 1)
		inject: aLook
		into: [ :e :f | e perform: f ].
	^ receiver perform: (path last asString , ':') asSymbol with: anObject
]
