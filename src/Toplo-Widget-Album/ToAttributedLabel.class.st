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

	frozen := aBoolean
]

{ #category : #initialization }
ToAttributedLabel >> initialize [ 

	super initialize.
	self defaultSkin: ToNullSkin new
]

{ #category : #testing }
ToAttributedLabel >> isFrozen [

	^ frozen ifNil: [ frozen := false ]
]

{ #category : #configuration }
ToAttributedLabel >> unfreeze [

	self frozen: false
]
