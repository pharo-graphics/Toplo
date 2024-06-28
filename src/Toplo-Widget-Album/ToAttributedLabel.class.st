Class {
	#name : #ToAttributedLabel,
	#superclass : #ToLabel,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToAttributedLabel >> initialize [

	super initialize.
	self withNullSkin
]

{ #category : #styling }
ToAttributedLabel >> styleWith: aBlock [

	aBlock cull: self.
	self style
]
