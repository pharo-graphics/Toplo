Class {
	#name : #ToAttributedLabel,
	#superclass : #ToLabel,
	#instVars : [
		'frozen'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #configuration }
ToAttributedLabel >> freeze [

	self frozen: true
]

{ #category : #accessing }
ToAttributedLabel >> frozen: aBoolean [

	frozen := aBoolean.
	aBoolean ifFalse: [ self attributesBuilder applyOn: self text ]
]

{ #category : #initialization }
ToAttributedLabel >> initialize [ 

	super initialize.
	self withNullSkin 
]

{ #category : #testing }
ToAttributedLabel >> isFrozen [

	^ frozen ifNil: [ frozen := false ]
]

{ #category : #'private-change' }
ToAttributedLabel >> privateText: aText [

	super privateText: aText.
	self isFrozen ifTrue: [ ^ self ].
	self attributesBuilder applyOn: self text
]

{ #category : #configuration }
ToAttributedLabel >> unfreeze [

	self frozen: false
]
