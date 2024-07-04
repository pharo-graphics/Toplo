Class {
	#name : #ToAttributedLabel,
	#superclass : #ToLabel,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #skin }
ToAttributedLabel >> newRawSkin [ 

	^ ToNullSkin new
]

{ #category : #styling }
ToAttributedLabel >> styleWith: aBlock [

	aBlock cull: self.
	self applyStyle
]
