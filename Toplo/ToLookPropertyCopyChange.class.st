Class {
	#name : #ToLookPropertyCopyChange,
	#superclass : #ToLookPropertyChange,
	#category : #'Toplo-Core-Changes'
}

{ #category : #initialization }
ToLookPropertyCopyChange >> initialize [
	super initialize.
	up := [ :e :f | 
	self
		writeOn: e
		value:
			(value isBlock
				ifTrue: [ value cull: f ]
				ifFalse: [ value ]) copy ].
	down := [ :e :f :g | self writeOn: e value: f copy ]
]

{ #category : #printing }
ToLookPropertyCopyChange >> printOn: aStream [
	aStream nextPutAll: 'copy '.
	super printOn: aStream
]
