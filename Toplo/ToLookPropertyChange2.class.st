Class {
	#name : #ToLookPropertyChange2,
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
ToLookPropertyChange2 >> downOn: aLook [
	self assert: [ initialized ].
	down value: aLook value: old value: new.
	old := nil.
	new := nil.
	initialized := false
]

{ #category : #initialization }
ToLookPropertyChange2 >> initialize [
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
ToLookPropertyChange2 >> path [
	^ path
]

{ #category : #accessing }
ToLookPropertyChange2 >> path: anObject [
	path := anObject
]

{ #category : #printing }
ToLookPropertyChange2 >> printOn: aStream [
	aStream nextPutAll: (' ' join: (path collect: #asString))
]

{ #category : #initialization }
ToLookPropertyChange2 >> readOn: aLook [

	^ path inject: aLook into: [ :e :f | e perform: f ]
]

{ #category : #initialization }
ToLookPropertyChange2 >> upOn: aLook [
	self assert: [ initialized not ].
	old := read value: aLook.
	up value: aLook value: old.
	new := read value: aLook.
	initialized := true
]

{ #category : #accessing }
ToLookPropertyChange2 >> value [
	^ value
]

{ #category : #accessing }
ToLookPropertyChange2 >> value: anObject [
	value := anObject
]

{ #category : #initialization }
ToLookPropertyChange2 >> writeOn: aLook value: anObject [
	| receiver |
	receiver := (path copyFrom: 1 to: path size - 1)
		inject: aLook
		into: [ :e :f | e perform: f ].
	^ receiver perform: (path last asString , ':') asSymbol with: anObject
]
